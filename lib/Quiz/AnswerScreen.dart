import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../HomeScreen.dart';
import '../customWidget/customWidgetMethods.dart';
import '../utils/colorConst.dart';
import 'UserAnswerScreen.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({
    super.key,
    required this.score,
    required this.maxScore,
    required this.questions,
    required this.answers,
    required this.userAnswer,
  });

  final int score;
  final int maxScore;
  final List<dynamic> questions;
  final List<dynamic> answers;
  final List<dynamic> userAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildImageBasedOnScore(context),
            const SizedBox(height: 30),
            buildScoreText(context),
            const SizedBox(height: 30),
            buildOutOfText(context),
            const SizedBox(height: 30),
            buildElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              ),
              label: AppLocalizations.of(context)?.goToHome ?? 'Go To Home -> erro',
            ),
            const SizedBox(height: 10),
            buildElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserAnswerScreen(
                    answers: answers,
                    questions: questions,
                    userAnswer: userAnswer,
                  ),
                ),
              ),
              label: AppLocalizations.of(context)?.checkYourAnswer ?? 'Check Your Answer - erro',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageBasedOnScore(BuildContext context) {
    if (score * 100 / maxScore > 75)
      return Image.asset(getAssetPath('congratulation', 'gif', context));
    else if (score * 100 / maxScore > 40)
      return Image.asset(getAssetPath('nice-try', 'gif', context));
    else
      return Image.asset(getAssetPath('betterluck', 'jpg', context));
  }

  Widget buildScoreText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.scoreIs + score.toString(),
      style: const TextStyle(
        fontSize: 25,
        color: baseColorLight,
      ),
    );
  }

  Widget buildOutOfText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.outOf + maxScore.toString(),
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  Widget buildElevatedButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: baseColor,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Locale getCurrentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  String getAssetPath(String baseName, String fileExtension, BuildContext context) {
    final Locale currentLocale = getCurrentLocale(context);
    final String languageCode = currentLocale.languageCode;

    if (languageCode == 'es') {
      return 'assets/$baseName-es.$fileExtension';
    } else if (languageCode == 'pt') {
      return 'assets/$baseName-pt.$fileExtension';
    } else {
      return 'assets/$baseName.$fileExtension';
    }
  }
}

