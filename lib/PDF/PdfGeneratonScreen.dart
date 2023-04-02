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
                    onPressed: () async => noMCQ(context),
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
                    onPressed: () async => withMCQ(context),
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

  Future<void> showPDF(
      pw.Document pdf, BuildContext context, String name) async {
    // chack if the user is on web  or app
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
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = '$name${DateTime.now().millisecondsSinceEpoch}.pdf';
      html.document.body!.children.add(anchor);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewer(
            pdfName: '$name${DateTime.now().millisecondsSinceEpoch}.pdf',
            pdfSave: bytes,
            anchor: anchor,
          ),
        ),
      );
    } else {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String fileName =
          '$name${DateTime.now().millisecondsSinceEpoch}.pdf';
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
                  pdfName: fileName.toString(), path: path, pdfSave: pdf)));
      totalQuestion = [];
      answerBank = [];
      questionBank = [];
      totalQuestionAnswer = [];
    }
  }

  Future<void> withMCQ(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // to show the Progress bar
      setState(() {
        isLoading = !isLoading;
      });
      final List<Object> ansData = [];
      final List<dynamic> ans = [];
      bool addMeInArray = false;
      List<List<dynamic>> finalMcqPrint = [];
      List<List<dynamic>> finalMcqAnswerPrint = [];
      final List<dynamic> totalQuestionMCQ = [];
      finalMcqPrint.add(['Questors']);
      finalMcqAnswerPrint.add([
        'Answers',
      ]);

      // generate the Questions and answers
      addMeInArray = generateWithMCQQueAns(
          addMeInArray, ansData, ans, totalQuestionMCQ, finalMcqAnswerPrint);

      for (int i = 0; i < totalQuestion.length; i++) {
        finalMcqPrint.add([totalQuestion[i]]);
        finalMcqPrint.add([totalQuestionMCQ[i]]);
      }

      if (!addMeInArray) {
        addMeInArray = true;
        finalMcqAnswerPrint.add(totalQuestionAnswer);
        totalQuestionAnswer = [];
      }

      // generate the pdf
      final pdf =
          generateWithMCQPDF(finalMcqPrint, finalMcqAnswerPrint, context);
      finalMcqAnswerPrint = [];
      finalMcqPrint = [];

      // show the pdf
      showPDF(pdf, context, 'WithMcq__');

      totalQuestion = [];
      answerBank = [];
      questionBank = [];
      totalQuestionAnswer = [];
    }
    setState(() {
      isLoading = !isLoading;
    });
  }

  bool generateWithMCQQueAns(
      bool addMeInArray,
      List<Object> ansData,
      List<dynamic> ans,
      List<dynamic> totalQuestionMCQ,
      List<List<dynamic>> finalMcqAnswerPrint) {
    for (var i = 1; i < int.parse(_ques.text) + 1; i++) {
      final val1 = Random().nextInt(int.parse(_range1.text)) + 1;
      final val2 = Random().nextInt(int.parse(_range2.text)) + 1;
      addMeInArray = false;

      // this is not optimal because we chack the oprator type every time
      if (widget.operator == 'sum') {
        totalQuestion.add('$i]      $val1  +  $val2 =  ? ');

        // make choices;
        ansData = [
          val1 + val2,
          val1 + val2 + Random().nextInt(10) + 1,
          val1 + val2 - Random().nextInt(10) - 1,
          val1 + val2 + Random().nextInt(16) + 1,
        ];

        final correctAnsValue = val1 + val2;

        ans = dontKnowWhatToNameIt(
            ansData, ans, correctAnsValue, totalQuestionMCQ, i);
      } else if (widget.operator == 'minus') {
        totalQuestion.add('$i]      $val1  -  $val2 =  ? ');
        ansData = [
          val1 - val2,
          val1 - val2 + Random().nextInt(10) + 1,
          val1 - val2 - Random().nextInt(10) - 1,
          val1 - val2 + Random().nextInt(16) + 1,
        ];

        final correctAnsValue = val1 - val2;
        ans = dontKnowWhatToNameIt(
            ansData, ans, correctAnsValue, totalQuestionMCQ, i);
      } else if (widget.operator == 'multiplication') {
        totalQuestion.add('$i]      $val1  *  $val2 =  ? ');
        ansData = [
          val1 * val2,
          val1 * val2 + Random().nextInt(10) + 1,
          val1 * val2 - Random().nextInt(10) - 1,
          val1 * val2 + Random().nextInt(16) + 1,
        ];

        final correctAnsValue = val1 * val2;
        ans = dontKnowWhatToNameIt(
            ansData, ans, correctAnsValue, totalQuestionMCQ, i);
      } else {
        totalQuestion.add('$i]      $val1  /  $val2 =  ? ');
        ansData = [
          double.parse((val1 / val2).toStringAsFixed(2)),
          double.parse(
              (val1 / val2 + Random().nextInt(10) + 1).toStringAsFixed(2)),
          double.parse(
              (val1 / val2 - Random().nextInt(10) - 1).toStringAsFixed(2)),
          double.parse(
              (val1 / val2 + Random().nextInt(16) + 1).toStringAsFixed(2)),
        ];
        final correctAnsValue = double.parse((val1 / val2).toStringAsFixed(2));
        ans = dontKnowWhatToNameIt(
            ansData, ans, correctAnsValue, totalQuestionMCQ, i);
      }
      if (i % 7 == 0) {
        addMeInArray = true;

        finalMcqAnswerPrint.add(totalQuestionAnswer);
        totalQuestionAnswer = [];
      }
    }
    return addMeInArray;
  }

  List<dynamic> dontKnowWhatToNameIt(List<Object> ansData, List<dynamic> ans,
      num correctAnsValue, List<dynamic> totalQuestionMCQ, int i) {
    // randomize the order of questions
    for (var j = 0; j < 4; j++) {
      final rNum = Random().nextInt(ansData.length).round();
      ans.add(ansData[rNum]);
      ansData.removeAt(rNum);
    }

    // get the Char of correct answer
    final choicesChar = ['A', 'B', 'C', 'D'];
    final index = ans.indexOf(correctAnsValue);
    final char = choicesChar[index];

    totalQuestionMCQ
        .add('A) ${ans[0]} O B) ${ans[1]} O C) ${ans[2]} O D) ${ans[3]} O ');
    totalQuestionAnswer.add('$i] $char');
    ans = [];
    return ans;
  }

  pw.Document generateWithMCQPDF(List<List<dynamic>> finalMcqPrint,
      List<List<dynamic>> finalMcqAnswerPrint, BuildContext context) {
    final pdf = pw.Document();
    try {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.portrait,
          build: (pw.Context context) => <pw.Widget>[
            pw.Table.fromTextArray(context: context, data: finalMcqPrint),
            pw.Padding(padding: const pw.EdgeInsets.all(10))
          ],
        ),
      );
      pdf.addPage(
        pw.MultiPage(
          build: (pw.Context context) => <pw.Widget>[
            pw.Padding(padding: const pw.EdgeInsets.all(5)),
            pw.Header(text: 'Answer Sheet'),
            pw.Table.fromTextArray(context: context, data: finalMcqAnswerPrint)
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Button moved to separate widget'),
        duration: Duration(seconds: 3),
      ));
    }
    return pdf;
  }

  Future<void> noMCQ(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = !isLoading;
      });

      // this variable is used to trac tthe rows of the table
      bool addMeInArray = false;

      // Headers of the Table
      questionBank.add(['Questions', 'Questions', 'Questions']);
      answerBank.add(['Answer', 'Answer', 'Answer']);

      // generate questions and answers
      addMeInArray = generateNoMCQQueAns(addMeInArray);

      if (!addMeInArray) {
        addMeInArray = true;
        questionBank.add(totalQuestion);
        totalQuestion = [];
        answerBank.add(totalQuestionAnswer);
        totalQuestionAnswer = [];
      }

      // generate the PDF
      final pdf = generateNoMCQPDF();

      // show the PDF
      await showPDF(pdf, context, 'NoMcq__');

      setState(() {
        isLoading = !isLoading;
      });
    }
  }

  pw.Document generateNoMCQPDF() {
    final pdf = pw.Document();

    // the questions page
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => <pw.Widget>[
          pw.Header(level: 0, text: 'Questions'),
          pw.Table.fromTextArray(context: context, data: questionBank),
          pw.Padding(padding: const pw.EdgeInsets.all(10))
        ],
      ),
    );

    // the aswers page
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => <pw.Widget>[
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Header(text: 'Answer Sheet'),
          pw.Table.fromTextArray(context: context, data: answerBank)
        ],
      ),
    );
    questionBank = [];
    answerBank = [];
    return pdf;
  }

  bool generateNoMCQQueAns(bool addMeInArray) {
    for (var i = 1; i < int.parse(_ques.text) + 1; i++) {
      addMeInArray = false;
      final val1 = Random().nextInt(int.parse(_range1.text)) + 1;
      final val2 = Random().nextInt(int.parse(_range2.text)) + 1;
      if (widget.operator == 'sum') {
        totalQuestion.add('$i]  $val1  +  $val2 =  ______ ');
        totalQuestionAnswer.add('$i]  $val1  +  $val2 =  ${val1 + val2} ');
      } else if (widget.operator == 'minus') {
        totalQuestion.add('$i]  $val1  -  $val2 =  ______ ');
        totalQuestionAnswer.add('$i]  $val1  -  $val2 =  ${val1 - val2} ');
      } else if (widget.operator == 'multiplication') {
        totalQuestion.add('$i]  $val1  *  $val2 =  ______ ');
        totalQuestionAnswer.add('$i]  $val1  *  $val2 =  ${val1 * val2} ');
      } else {
        totalQuestion.add('$i]  $val1  /  $val2 =  ______ ');
        totalQuestionAnswer.add(
            '$i]  $val1  /  $val2 =  ${(val1 / val2).toStringAsFixed(2)} ');
      }

      // just to make sure that there are 3 questions in each line
      if (i % 3 == 0) {
        addMeInArray = true;
        questionBank.add(totalQuestion);
        totalQuestion = [];
        answerBank.add(totalQuestionAnswer);
        totalQuestionAnswer = [];
      }
    }
    return addMeInArray;
  }
}
