import 'dart:io';
import 'dart:math';
import 'package:mathamatics/customWidget/MainScreenCard.dart';
import 'package:mathamatics/customWidget/customWidgetMethods.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PdfGenerationScreen extends StatefulWidget {
  final IconData icon;
  final operator;

  PdfGenerationScreen({Key key, this.icon, this.operator}) : super(key: key);

  @override
  _PdfGenerationScreenState createState() => _PdfGenerationScreenState();
}

class _PdfGenerationScreenState extends State<PdfGenerationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ques = TextEditingController();
  final TextEditingController _range1 = TextEditingController();
  final TextEditingController _range2 = TextEditingController();
  bool isLoading = false;
  List<dynamic> totalQueseion = [];
  List<List<dynamic>> answerBank = [];
  List<List<dynamic>> questionBank = [];
  List<dynamic> totalQueseionAnswer = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.pinkAccent,
      appBar: customAppBar(context),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Center(
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SingleChildScrollView(
              physics: ScrollPhysics(parent: ScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Hero(tag: widget.icon, child: Icon(widget.icon, size: 70, color: Colors.yellow)),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MainScreenCard(ques: _ques, icon: widget.icon, max: 3, lable: "How Many Question", maxValue: 100, hint: "20"),
                        MainScreenCard(ques: _range1, icon: widget.icon, max: 5, lable: "Start Value", hint: "35"),
                        MainScreenCard(ques: _range2, icon: widget.icon, max: 5, lable: "End Value", hint: "58"),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        bool addMeInArray = false;
                        questionBank.add(["Questons", "Questons", "Questons"]);
                        answerBank.add(["Answer", "Answer", "Answer"]);
                        for (var i = 1; i < int.parse(_ques.text) + 1; i++) {
                          addMeInArray = false;
                          var val1 = Random().nextInt(int.parse(_range1.text)) + 1;
                          var val2 = Random().nextInt(int.parse(_range2.text)) + 1;

                          if (widget.operator == "sum") {
                            totalQueseion.add("$i]  $val1  +  $val2 =  ______ ");
                            totalQueseionAnswer.add("$i]  $val1  +  $val2 =  ${val1 + val2} ");
                          } else if (widget.operator == "minus") {
                            totalQueseion.add("$i]  $val1  -  $val2 =  ______ ");
                            totalQueseionAnswer.add("$i]  $val1  -  $val2 =  ${val1 - val2} ");
                          } else if (widget.operator == "multification") {
                            totalQueseion.add("$i]  $val1  *  $val2 =  ______ ");
                            totalQueseionAnswer.add("$i]  $val1  *  $val2 =  ${val1 * val2} ");
                          } else {
                            totalQueseion.add("$i]  $val1  /  $val2 =  ______ ");
                            totalQueseionAnswer.add("$i]  $val1  /  $val2 =  ${(val1 / val2).toStringAsFixed(2)} ");
                          }
                          if (i % 3 == 0) {
                            addMeInArray = true;
                            questionBank.add(totalQueseion);
                            totalQueseion = [];
                            answerBank.add(totalQueseionAnswer);
                            totalQueseionAnswer = [];
                          }
                        }
                        if (!addMeInArray) {
                          addMeInArray = true;
                          questionBank.add(totalQueseion);
                          totalQueseion = [];
                          answerBank.add(totalQueseionAnswer);
                          totalQueseionAnswer = [];
                        }

                        final pdf = pw.Document();
                        pdf.addPage(
                          pw.MultiPage(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            build: (pw.Context context) => <pw.Widget>[pw.Table.fromTextArray(context: context, data: questionBank), pw.Padding(padding: pw.EdgeInsets.all(10))],
                          ),
                        );
                        pdf.addPage(
                          pw.MultiPage(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            build: (pw.Context context) => <pw.Widget>[
                              pw.Padding(padding: pw.EdgeInsets.all(10)),
                              pw.Header(level: 1, text: 'Answer Sheet'),
                              pw.Table.fromTextArray(context: context, data: answerBank)
                            ],
                          ),
                        );
                        questionBank = [];
                        answerBank = [];
                        if (kIsWeb) {
                          final bytes = pdf.save();
                          final blob = html.Blob([bytes], 'application${Random().nextInt(1000)}/pdf');
                          final url = html.Url.createObjectUrlFromBlob(blob);
                          final anchor = html.document.createElement('a') as html.AnchorElement
                            ..href = url
                            ..style.display = 'none'
                            ..download = 'NoMcq${Random().nextInt(1000)}.pdf';
                          html.document.body.children.add(anchor);
                          anchor.click();
                          html.document.body.children.remove(anchor);
                          html.Url.revokeObjectUrl(url);
                        } else {
                          String dir = (await getApplicationDocumentsDirectory()).path;

                          String fileName = "NoMcq${Random().nextInt(1000)}.pdf";
                          String path = '$dir/$fileName';
                          final File file = File(path);
                          file.writeAsBytesSync(pdf.save());

                          try {
                            await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
                          } catch (e) {
                            print('Error $e');
                          }
                          totalQueseion = [];
                          answerBank = [];
                          questionBank = [];
                          totalQueseionAnswer = [];
                        }

                        setState(() {
                          isLoading = !isLoading;
                        });
                      }
                    },
                    elevation: 10,
                    color: Colors.yellow,
                    child: Padding(padding: EdgeInsets.all(8.0), child: Text("QUESTIONS", style: TextStyle(color: Colors.pink, fontSize: 30, fontWeight: FontWeight.bold))),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = !isLoading;
                      });
                      if (_formKey.currentState.validate()) {
                        var ansData;
                        List ans = [];
                        bool addMeInArray = false;
                        List<List<dynamic>> finalMcqPrint = [];
                        List<List<dynamic>> finalMcqAnswerPrint = [];
                        List<dynamic> totalQueseionMCQ = [];
                        finalMcqPrint.add(["Questons"]);
                        finalMcqAnswerPrint.add([
                          "Answers",
                        ]);
                        for (var i = 1; i < int.parse(_ques.text) + 1; i++) {
                          var val1 = Random().nextInt(int.parse(_range1.text)) + 1;
                          var val2 = Random().nextInt(int.parse(_range2.text)) + 1;
                          addMeInArray = false;
                          if (widget.operator == "sum") {
                            totalQueseion.add("$i]      $val1  +  $val2 =  ? ");
                            ansData = [
                              val1 + val2,
                              val1 + val2 + Random().nextInt(10) + 1,
                              val1 + val2 - Random().nextInt(10) - 1,
                              val1 + val2 + Random().nextInt(16) + 1,
                            ];

                            for (var j = 0; j < 4; j++) {
                              var rNum = Random().nextInt(ansData.length).round();
                              ans.add(ansData[rNum]);
                              ansData.removeAt(rNum);
                            }
                            var index = ans.indexOf(val1 + val2);
                            var char = index == 0
                                ? 'A'
                                : index == 1
                                    ? 'B'
                                    : index == 2
                                        ? 'C'
                                        : 'D';
                            totalQueseionMCQ.add("A) ${ans[0]}   O    B) ${ans[1]}   O    C) ${ans[2]}   O    D) ${ans[3]}   O   ");
                            totalQueseionAnswer.add("$i] $char");
                            ans = [];
                          } else if (widget.operator == "minus") {
                            totalQueseion.add("$i]      $val1  -  $val2 =  ? ");
                            ansData = [
                              val1 - val2,
                              val1 - val2 + Random().nextInt(10) + 1,
                              val1 - val2 - Random().nextInt(10) - 1,
                              val1 - val2 + Random().nextInt(16) + 1,
                            ];

                            for (var j = 0; j < 4; j++) {
                              var rNum = Random().nextInt(ansData.length).round();
                              ans.add(ansData[rNum]);
                              ansData.removeAt(rNum);
                            }
                            var index = ans.indexOf(val1 - val2);
                            var char = index == 0
                                ? 'A'
                                : index == 1
                                    ? 'B'
                                    : index == 2
                                        ? 'C'
                                        : 'D';
                            totalQueseionMCQ.add("A) ${ans[0]}   O    B) ${ans[1]}   O    C) ${ans[2]}   O    D) ${ans[3]}   O   ");
                            totalQueseionAnswer.add("$i] $char");
                            ans = [];
                          } else if (widget.operator == "multification") {
                            totalQueseion.add("$i]      $val1  *  $val2 =  ? ");
                            ansData = [
                              val1 * val2,
                              val1 * val2 + Random().nextInt(10) + 1,
                              val1 * val2 - Random().nextInt(10) - 1,
                              val1 * val2 + Random().nextInt(16) + 1,
                            ];

                            for (var j = 0; j < 4; j++) {
                              var rNum = Random().nextInt(ansData.length).round();
                              ans.add(ansData[rNum]);
                              ansData.removeAt(rNum);
                            }
                            var index = ans.indexOf(val1 * val2);
                            var char = index == 0
                                ? 'A'
                                : index == 1
                                    ? 'B'
                                    : index == 2
                                        ? 'C'
                                        : 'D';
                            totalQueseionMCQ.add("A) ${ans[0]}   O    B) ${ans[1]}   O    C) ${ans[2]}   O    D) ${ans[3]}   O   ");
                            totalQueseionAnswer.add("$i] $char");
                            ans = [];
                          } else {
                            totalQueseion.add("$i]      $val1  /  $val2 =  ? ");
                            ansData = [
                              (val1 / val2).toStringAsFixed(2),
                              (val1 / val2 + Random().nextInt(10) + 1).toStringAsFixed(2),
                              (val1 / val2 - Random().nextInt(10) - 1).toStringAsFixed(2),
                              (val1 / val2 + Random().nextInt(16) + 1).toStringAsFixed(2),
                            ];

                            for (var j = 0; j < 4; j++) {
                              var rNum = Random().nextInt(ansData.length).round();
                              ans.add(ansData[rNum]);
                              ansData.removeAt(rNum);
                            }
                            var index = ans.indexOf((val1 / val2).toStringAsFixed(2));
                            var char = index == 0
                                ? 'A'
                                : index == 1
                                    ? 'B'
                                    : index == 2
                                        ? 'C'
                                        : 'D';
                            totalQueseionMCQ.add("A) ${ans[0]}   O    B) ${ans[1]}   O    C) ${ans[2]}   O    D) ${ans[3]}   O   ");
                            totalQueseionAnswer.add("$i] $char");
                            ans = [];
                          }
                          if (i % 7 == 0) {
                            addMeInArray = true;

                            finalMcqAnswerPrint.add(totalQueseionAnswer);
                            totalQueseionAnswer = [];
                          }
                        }
                        for (int i = 0; i < totalQueseion.length; i++) {
                          finalMcqPrint.add([totalQueseion[i]]);
                          finalMcqPrint.add([totalQueseionMCQ[i]]);
                        }

                        if (!addMeInArray) {
                          addMeInArray = true;
                          finalMcqAnswerPrint.add(totalQueseionAnswer);
                          totalQueseionAnswer = [];
                        }
                        final pdf = pw.Document();
                        try {
                          pdf.addPage(
                            pw.MultiPage(
                              pageFormat: PdfPageFormat.a4,
                              orientation: pw.PageOrientation.portrait,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              build: (pw.Context context) => <pw.Widget>[pw.Table.fromTextArray(context: context, data: finalMcqPrint), pw.Padding(padding: pw.EdgeInsets.all(10))],
                            ),
                          );
                          pdf.addPage(
                            pw.MultiPage(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              build: (pw.Context context) => <pw.Widget>[
                                pw.Padding(padding: pw.EdgeInsets.all(5)),
                                pw.Header(level: 1, text: 'Answer Sheet'),
                                pw.Table.fromTextArray(context: context, data: finalMcqAnswerPrint)
                              ],
                            ),
                          );
                        } catch (e) {
                          print("error $e");

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Button moved to separate widget'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                        finalMcqAnswerPrint = [];
                        finalMcqPrint = [];

                        if (kIsWeb) {
                          final bytes = pdf.save();
                          final blob = html.Blob([bytes], 'application${Random().nextInt(1000)}/pdf');
                          final url = html.Url.createObjectUrlFromBlob(blob);
                          final anchor = html.document.createElement('a') as html.AnchorElement
                            ..href = url
                            ..style.display = 'none'
                            ..download = 'WithMcq${Random().nextInt(1000)}.pdf';
                          html.document.body.children.add(anchor);
                          anchor.click();
                          html.document.body.children.remove(anchor);
                          html.Url.revokeObjectUrl(url);
                        } else {
                          String dir = (await getApplicationDocumentsDirectory()).path;

                          String fileName = "WithMcq${Random().nextInt(1000)}.pdf";
                          String path = '$dir/$fileName';
                          final File file = File(path);
                          await file.writeAsBytesSync(pdf.save());

                          try {
                            await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
                          } catch (e) {
                            print('Error $e');
                          }
                        }
                        totalQueseion = [];
                        answerBank = [];
                        questionBank = [];
                        totalQueseionAnswer = [];
                      }
                      setState(() {
                        isLoading = !isLoading;
                      });
                    },
                    elevation: 10,
                    color: Colors.yellow,
                    child: Padding(padding: EdgeInsets.all(8.0), child: Text("MCQ", style: TextStyle(color: Colors.pink, fontSize: 30, fontWeight: FontWeight.bold))),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
