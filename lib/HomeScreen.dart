import 'package:flutter/material.dart';
import 'AskOperator.dart';
import 'customWidget/DisplayButton.dart';

import 'customWidget/shared_appbar.dart';

import 'customWidget/customWidgetMethods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: sharedAppBar(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: ScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Image.asset('assets/HomeScreen.jpg'),
            ),
            const SizedBox(height: 50),
            DisplayButton(
              text: 'Generate PDF',
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AskOperator(isQuiz: false),
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height * 20) / 816,
            ),
            DisplayButton(
              text: 'Quiz',
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AskOperator(isQuiz: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
