import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class PdfViewer extends StatefulWidget {
  final pdfName;
  final path;
  final pdfSave;
  final anchor;
  const PdfViewer({this.pdfName, this.path, this.pdfSave, this.anchor});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          elevation: 1,
          title: Text(
            widget.pdfName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, letterSpacing: 2, fontSize: 20),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.download_sharp),
              onPressed: () {
                if (!kIsWeb) {
                  try {
                    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => widget.pdfSave.save());
                  } catch (e) {
                    print(e);
                  }
                } else {
                  widget.anchor.click();
                  html.document.body!.children.remove(widget.anchor);
                }
              },
            )
          ],
        ),
        body: kIsWeb ? SfPdfViewer.memory(widget.pdfSave) : SfPdfViewer.file(File(widget.path)));
  }
}
