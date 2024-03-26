import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../customWidget/shared_appbar.dart';
import '../utils/colorConst.dart';

class UserAnswerScreen extends StatefulWidget {
  const UserAnswerScreen({
    required this.questions,
    required this.answers,
    required this.userAnswer,
    super.key,
  });
  final List<dynamic> questions;
  final List<dynamic> answers;
  final List<dynamic> userAnswer;

  @override
  _UserAnswerScreenState createState() => _UserAnswerScreenState();
}

class _UserAnswerScreenState extends State<UserAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: sharedAppBar(),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width > 700
                    ? 600
                    : double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Card(
                      color: baseColor,
                      elevation: 10,
                      child: ListTile(
                        leading: widget.userAnswer[i].toString() ==
                                widget.answers[i].toString()
                            ? const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.check,
                                  color: baseColorLight,
                                ))
                            : const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.xmark,
                                  color: redColorLight,
                                ),
                              ),
                        title: Text(widget.questions[i].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text((AppLocalizations.of(context)?.answer ?? 'Answer = > erro') + widget.answers[i].toString(),
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 15)),
                        trailing: Text(widget.userAnswer[i].toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.orangeAccent)),
                      ),
                    );
                  },
                  itemCount: widget.answers.length,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
