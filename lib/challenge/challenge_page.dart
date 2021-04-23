import 'package:DevQuiz/challenge/challenge_controller.dart';
import 'package:DevQuiz/result/result_page.dart';
import 'package:flutter/material.dart';

import 'package:DevQuiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:DevQuiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:DevQuiz/shared/models/question_model.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;
  const ChallengePage({
    Key? key,
    required this.title,
    required this.questions,
  }) : super(key: key);
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  @override
  initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt();
    });
    super.initState();
  }

  void nextPage() {
    if (controller.currentPage < widget.questions.length - 1)
      pageController.nextPage(
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
      );
  }

  void onSelected(bool value) {
    if (value) {
      controller.hits++;
    }
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(78),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map((e) => QuizWidget(
                  question: e,
                  onSelected: onSelected,
                ))
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
            child: ValueListenableBuilder<int>(
              valueListenable: controller.currentPageNotifier,
              builder: (context, value, _) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if ((value + 1) < widget.questions.length)
                    Expanded(
                        child: NextButtonWidget.white(
                      label: "Pular",
                      onTap: () {
                        nextPage();
                      },
                    )),
                  if ((value + 1) == widget.questions.length)
                    SizedBox(
                      width: 7,
                    ),
                  if ((value + 1) == widget.questions.length)
                    Expanded(
                        child: NextButtonWidget.green(
                      label: "Confirmar",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(
                              result: controller.hits,
                              title: widget.title,
                              length: widget.questions.length,
                            ),
                          ),
                        );
                      },
                    )),
                ],
              ),
            )),
      ),
    );
  }
}
