import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

import '../customWidget/MainScreenCard.dart';
import '../customWidget/customWidgetMethods.dart';
import '../utils/colorConst.dart';
import 'PdfViewer.dart';

class PdfGenerationScreen extends StatefulWidget {
  const PdfGenerationScreen({
    super.key,
    required this.icon,
    required this.operator,
  });
  final IconData icon;
  final String operator;

  @override
  _PdfGenerationScreenState createState() => _PdfGenerationScreenState();
}

Uint8List? bytes;

class _PdfGenerationScreenState extends State<PdfGenerationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ques = TextEditingController();
  final TextEditingController _range1 = TextEditingController();
  final TextEditingController _range2 = TextEditingController();
  Uint8List? bytes;

  bool isLoading = false;
  List<dynamic> totalQuestion = [];
  List<List<dynamic>> answerBank = [];
  List<List<dynamic>> questionBank = [];
  List<dynamic> totalQuestionAnswer = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Center(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(parent: ScrollPhysics()),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Hero(
                    tag: widget.icon,
                    child: Icon(
                      widget.icon,
                      size: 70,
                      color: baseColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MainScreenCard(
                          ques: _ques,
                          icon: widget.icon,
                          max: 3,
                          label: 'How Many Question',
                          maxValue: 100,
                          hint: '20',
                        ),
                        MainScreenCard(
                          ques: _range1,
                          icon: widget.icon,
                          max: 5,
                          label: 'Start Value',
                          hint: '35',
                        ),
                        MainScreenCard(
                          ques: _range2,
                          icon: widget.icon,
                          max: 5,
                          label: 'End Value',
                          hint: '58',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        bool addMeInArray = false;
                        questionBank
                            .add(['Questions', 'Questions', 'Questions']);
                        answerBank.add(['Answer', 'Answer', 'Answer']);
                        for (var i = 1; i < int.parse(_ques.text) + 1; i++) {
                          addMeInArray = false;
                          final val1 =
                              Random().nextInt(int.parse(_range1.text)) + 1;
                          final val2 =
                              Random().nextInt(int.parse(_range2.text)) + 1;
                          if (widget.operator == 'sum') {
                            totalQuestion
                                .add('$i]  $val1  +  $val2 =  ______ ');
                            totalQuestionAnswer
                                .add('$i]  $val1  +  $val2 =  ${val1 + val2} ');
                          } else if (widget.operator == 'minus') {
                            totalQuestion
                                .add('$i]  $val1  -  $val2 =  ______ ');
                            totalQuestionAnswer
                                .add('$i]  $val1  -  $val2 =  ${val1 - val2} ');
                          } else if (widget.operator == 'multiplication') {
                            totalQuestion
                                .add('$i]  $val1  *  $val2 =  ______ ');
                            totalQuestionAnswer
                                .add('$i]  $val1  *  $val2 =  ${val1 * val2} ');
                          } else {
                            totalQuestion
                                .add('$i]  $val1  /  $val2 =  ______ ');
                            totalQuestionAnswer.add(
                                '$i]  $val1  /  $val2 =  ${(val1 / val2).toStringAsFixed(2)} ');
                          }
                          if (i % 3 == 0) {
                            addMeInArray = true;
                            questionBank.add(totalQuestion);
                            totalQuestion = [];
                            answerBank.add(totalQuestionAnswer);
                            totalQuestionAnswer = [];
                          }
                        }
                        if (!addMeInArray) {
                          addMeInArray = true;
                          questionBank.add(totalQuestion);
                          totalQuestion = [];
                          answerBank.add(totalQuestionAnswer);
                          totalQuestionAnswer = [];
                        }

                        final pdf = pw.Document();
                        pdf.addPage(
                          pw.MultiPage(
                            build: (pw.Context context) => <pw.Widget>[
                              pw.Header(level: 0, text: 'Questions'),
                              pw.Table.fromTextArray(
                                  context: context, data: questionBank),
                              pw.Padding(padding: const pw.EdgeInsets.all(10))
                            ],
                          ),
                        );
                        pdf.addPage(
                          pw.MultiPage(
                            build: (pw.Context context) => <pw.Widget>[
                              pw.Padding(padding: const pw.EdgeInsets.all(10)),
                              pw.Header(text: 'Answer Sheet'),
                              pw.Table.fromTextArray(
                                  context: context, data: answerBank)
                            ],
                          ),
                        );
                        questionBank = [];
                        answerBank = [];
                        if (kIsWeb) {
                          pdf.save().then((value) {
                            setState(() {
                              bytes = value;
                            });
                          });
                          await Future.delayed(const Duration(seconds: 1));
                          final blob = html.Blob(
                            [bytes],
                            'application${DateTime.now().millisecondsSinceEpoch}/pdf',
                          );
                          final url = html.Url.createObjectUrlFromBlob(blob);
                          final anchor = html.document.createElement('a')
                              as html.AnchorElement
                            ..href = url
                            ..style.display = 'none'
                            ..download =
                                'NoMcq__${DateTime.now().millisecondsSinceEpoch}.pdf';
                          html.document.body!.children.add(anchor);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewer(
                                pdfName:
                                    'NoMcq__${DateTime.now().millisecondsSinceEpoch}.pdf',
                                pdfSave: bytes,
                                anchor: anchor,
                              ),
                            ),
                          );
                        } else {
                          final String dir =
                              (await getApplicationDocumentsDirectory()).path;
                          final String fileName =
                              'NoMcq__${DateTime.now().millisecondsSinceEpoch}.pdf';
                          final String path = '$dir/$fileName';
                          final File file = File(path);
                          pdf.save().then((value) {
                            setState(() {
                              file.writeAsBytesSync(value);
                            });
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfViewer(
                                      pdfName: fileName.toString(),
                                      path: path,
                                      pdfSave: pdf)));
                          totalQuestion = [];
                          answerBank = [];
                          questionBank = [];
                          totalQuestionAnswer = [];
                        }
                        setState(() {
                          isLoading = !isLoading;
                        });
                      }
                    },
                    elevation: 30,
                    color: baseColor,
                    child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('QUESTIONS (No-MCQ)',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600))),
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = !isLoading;
                      });
                      if (_formKey.currentState!.validate()) {
                        List<Object> ansData;
                        List<dynamic> ans = [];
                        bool addMeInArray = false;
                        List<List<dynamic>> finalMcqPrint = [];
                        List<List<dynamic>> finalMcqAnswerPrint = [];
                        final List<dynamic> totalQuestionMCQ = [];
                        finalMcqPrint.add(['Questors']);
                        finalMcqAnswerPrint.add([
                          'Answers',
                        ]);
                        for (var i = 1; i < int.parse(_ques.text) + 1; i++) {
                          final val1 =
                              Random().nextInt(int.parse(_range1.text)) + 1;
                          final val2 =
                              Random().nextInt(int.parse(_range2.text)) + 1;
                          addMeInArray = false;
                          if (widget.operator == 'sum') {
                            totalQuestion.add('$i]      $val1  +  $val2 =  ? ');
                            ansData = [
                              val1 + val2,
                              val1 + val2 + Random().nextInt(10) + 1,
                              val1 + val2 - Random().nextInt(10) - 1,
                              val1 + val2 + Random().nextInt(16) + 1,
                            ];

                            for (var j = 0; j < 4; j++) {
                              final rNum =
                                  Random().nextInt(ansData.length).round();
                              ans.add(ansData[rNum]);
                              ansData.removeAt(rNum);
                            }
                            final index = ans.indexOf(val1 + val2);
                            final char = index == 0
                                ? 'A'
                                : index == 1
                                    ? 'B'
                                    : index == 2
                                        ? 'C'
                                        : 'D';
                            totalQuestionMCQ.add(
                                'A) ${ans[0]} O B) ${ans[1]} O C) ${ans[2]} O D) ${ans[3]} O ');
                            totalQuestionAnswer.add('$i] $char');
                            ans = [];
                          } else if (widget.operator == 'minus') {
                            totalQuestion.add('$i]      $val1  -  $val2 =  ? ');
                            ansData = [
                              val1 - val2,
                              val1 - val2 + Random().nextInt(10) + 1,
                              val1 - val2 - Random().nextInt(10) - 1,
                              val1 - val2 + Random().nextInt(16) + 1,
                            ];

                            for (var j = 0; j < 4; j++) {
                              final rNum =
                                  Random().nextInt(ansData.length).round();
                              ans.add(ansData[rNum]);
                              ansData.removeAt(rNum);
                            }
                            final index = ans.indexOf(val1 - val2);
                            final char = index == 0
                                ? 'A'
                                : index == 1
                                    ? 'B'
                                    : index == 2
                                        ? 'C'
                                        : 'D';
                            totalQuestionMCQ.add(
                                'A) ${ans[0]} O B) ${ans[1]} O C) ${ans[2]} O D) ${ans[3]} O ');
                            totalQuestionAnswer.add('$i] $char');
                            ans = [];
                          } else if (widget.operator == 'multiplication') {
                            totalQuestion.add('$i]      $val1  *  $val2 =  ? ');
                            ansData = [
                              val1 * val2,
                              val1 * val2 + Random().nextInt(10) + 1,
                              val1 * val2 - Random().nextInt(10) - 1,
                              val1 * val2 + Random().nextInt(16) + 1,
                            ];

                            for (var j = 0; j < 4; j++) {
                              final rNum =
                                  Random().nextInt(ansData.length).round();
                              ans.add(ansData[rNum]);
                              ansData.removeAt(rNum);
                            }
                            final index = ans.indexOf(val1 * val2);
                            final char = index == 0
                                ? 'A'
                                : index == 1
                                    ? 'B'
                                    : index == 2
                                        ? 'C'
                                        : 'D';
                            totalQuestionMCQ.add(
                                'A) ${ans[0]} O B) ${ans[1]} O C) ${ans[2]} O D) ${ans[3]} O ');
                            totalQuestionAnswer.add('$i] $char');
                            ans = [];
                          } else {
                            totalQuestion.add('$i]      $val1  /  $val2 =  ? ');
                            ansData = [
                              (val1 / val2).toStringAsFixed(2),
                              (val1 / val2 + Random().nextInt(10) + 1)
                                  .toStringAsFixed(2),
                              (val1 / val2 - Random().nextInt(10) - 1)
                                  .toStringAsFixed(2),
                              (val1 / val2 + Random().nextInt(16) + 1)
                                  .toStringAsFixed(2),
                            ];

                            for (var j = 0; j < 4; j++) {
                              final rNum =
                                  Random().nextInt(ansData.length).round();
                              ans.add(ansData[rNum]);
                              ansData.removeAt(rNum);
                            }
                            final index =
                                ans.indexOf((val1 / val2).toStringAsFixed(2));
                            final char = index == 0
                                ? 'A'
                                : index == 1
                                    ? 'B'
                                    : index == 2
                                        ? 'C'
                                        : 'D';
                            totalQuestionMCQ.add(
                                'A) ${ans[0]} O B) ${ans[1]} O C) ${ans[2]} O D) ${ans[3]} O ');
                            totalQuestionAnswer.add('$i] $char');
                            ans = [];
                          }
                          if (i % 7 == 0) {
                            addMeInArray = true;

                            finalMcqAnswerPrint.add(totalQuestionAnswer);
                            totalQuestionAnswer = [];
                          }
                        }
                        for (int i = 0; i < totalQuestion.length; i++) {
                          finalMcqPrint.add([totalQuestion[i]]);
                          finalMcqPrint.add([totalQuestionMCQ[i]]);
                        }
                        if (!addMeInArray) {
                          addMeInArray = true;
                          finalMcqAnswerPrint.add(totalQuestionAnswer);
                          totalQuestionAnswer = [];
                        }
                        final pdf = pw.Document();
                        try {
                          pdf.addPage(
                            pw.MultiPage(
                              pageFormat: PdfPageFormat.a4,
                              orientation: pw.PageOrientation.portrait,
                              build: (pw.Context context) => <pw.Widget>[
                                pw.Table.fromTextArray(
                                    context: context, data: finalMcqPrint),
                                pw.Padding(padding: const pw.EdgeInsets.all(10))
                              ],
                            ),
                          );
                          pdf.addPage(
                            pw.MultiPage(
                              build: (pw.Context context) => <pw.Widget>[
                                pw.Padding(padding: const pw.EdgeInsets.all(5)),
                                pw.Header(text: 'Answer Sheet'),
                                pw.Table.fromTextArray(
                                    context: context, data: finalMcqAnswerPrint)
                              ],
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Button moved to separate widget'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                        finalMcqAnswerPrint = [];
                        finalMcqPrint = [];
                        if (kIsWeb) {
                          pdf.save().then((value) {
                            setState(() {
                              bytes = value;
                            });
                          });
                          await Future.delayed(const Duration(seconds: 1));
                          final blob = html.Blob([
                            bytes
                          ], 'application${DateTime.now().millisecondsSinceEpoch}/pdf');
                          final url = html.Url.createObjectUrlFromBlob(blob);
                          final anchor = html.document.createElement('a')
                              as html.AnchorElement
                            ..href = url
                            ..style.display = 'none'
                            ..download =
                                'WithMcq__${DateTime.now().millisecondsSinceEpoch}.pdf';
                          html.document.body!.children.add(anchor);
                          /*  anchor.click();
                          html.document.body.children.remove(anchor);
                          html.Url.revokeObjectUrl(url);*/
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewer(
                                pdfName:
                                    'NoMcq__${DateTime.now().millisecondsSinceEpoch}.pdf',
                                pdfSave: bytes,
                                anchor: anchor,
                              ),
                            ),
                          );
                        } else {
                          final String dir =
                              (await getApplicationDocumentsDirectory()).path;

                          final String fileName =
                              'WithMcq__${DateTime.now().millisecondsSinceEpoch}.pdf';
                          final String path = '$dir/$fileName';
                          final file = File(path);

                          pdf.save().then((value) {
                            setState(() {
                              file.writeAsBytesSync(value);
                            });
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfViewer(
                                      pdfName: fileName.toString(),
                                      path: path,
                                      pdfSave: pdf)));
                        }
                        totalQuestion = [];
                        answerBank = [];
                        questionBank = [];
                        totalQuestionAnswer = [];
                      }
                      setState(() {
                        isLoading = !isLoading;
                      });
                    },
                    elevation: 30,
                    color: baseColor,
                    child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('MCQ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600))),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
