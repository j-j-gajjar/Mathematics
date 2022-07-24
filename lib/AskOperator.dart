import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'PDF/PdfGeneratonScreen.dart';
import 'Quiz/QuizQuestionScreen.dart';
import 'customWidget/ButtonIcon.dart';
import 'customWidget/customWidgetMethods.dart';

class AskOperator extends StatelessWidget {
  const AskOperator({super.key, required this.isQuiz});
  final bool isQuiz;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const CustomAppBar(),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(parent: ScrollPhysics()),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonIcon(
                          icon: FontAwesomeIcons.plus,
                          function: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => isQuiz
                                    ? const QuizQuestionScreen(
                                        icon: FontAwesomeIcons.plus,
                                      )
                                    : const PdfGenerationScreen(
                                        icon: FontAwesomeIcons.plus,
                                        operator: 'sum',
                                      ),
                              )),
                        ),
                        ButtonIcon(
                          icon: FontAwesomeIcons.minus,
                          function: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => isQuiz
                                    ? const QuizQuestionScreen(
                                        icon: FontAwesomeIcons.minus,
                                        operator: 'minus',
                                      )
                                    : const PdfGenerationScreen(
                                        icon: FontAwesomeIcons.minus,
                                        operator: 'minus',
                                      ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonIcon(
                          icon: FontAwesomeIcons.xmark,
                          function: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => isQuiz
                                    ? const QuizQuestionScreen(
                                        icon: FontAwesomeIcons.xmark,
                                        operator: 'multiplication')
                                    : const PdfGenerationScreen(
                                        icon: FontAwesomeIcons.xmark,
                                        operator: 'multiplication'),
                              )),
                        ),
                        ButtonIcon(
                          icon: FontAwesomeIcons.divide,
                          function: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => isQuiz
                                    ? const QuizQuestionScreen(
                                        icon: FontAwesomeIcons.divide,
                                        operator: 'division',
                                      )
                                    : const PdfGenerationScreen(
                                        icon: FontAwesomeIcons.divide,
                                        operator: 'division',
                                      ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
