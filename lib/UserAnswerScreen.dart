import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAnswerScreen extends StatefulWidget {
  final List qustions;
  final List answers;
  final List userAnswer;

  const UserAnswerScreen(
      {Key key, this.qustions, this.answers, this.userAnswer})
      : super(key: key);

  @override
  _UserAnswerScreenState createState() => _UserAnswerScreenState();
}

class _UserAnswerScreenState extends State<UserAnswerScreen> {
  InterstitialAd myInterstitial;
  MobileAdTargetingInfo targetingInfo;
  @override
  void initState() {
    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['maths', 'education', 'school', 'college', 'study'],
      contentUrl: 'https://flutter.io',
      birthday: DateTime.now(),
      childDirected: false,
      designedForFamilies: false,
      gender: MobileAdGender.unknown,
      testDevices: <String>[], // Android emulators are considered test devices
    );
    myInterstitial = InterstitialAd(
      adUnitId: "ca-app-pub-8093789261096390/8369331109",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (c, i) {
              return Card(
                color: Colors.pinkAccent,
                elevation: 10,
                child: ListTile(
                  leading: widget.userAnswer[i].toString() ==
                          widget.answers[i].toString()
                      ? CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(FontAwesomeIcons.check),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.red[900],
                          child: Icon(FontAwesomeIcons.times),
                        ),
                  title: Text(
                    widget.qustions[i].toString(),
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(widget.answers[i].toString(),
                      style: TextStyle(color: Colors.yellow, fontSize: 15)),
                  trailing: Text(
                    "${widget.userAnswer[i].toString()}",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              );
            },
            itemCount: widget.answers.length,
          ),
        ),
      ),
    );
  }
}
