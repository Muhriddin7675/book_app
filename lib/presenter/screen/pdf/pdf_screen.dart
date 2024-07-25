import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatefulWidget {
  final String url;

  const PDFScreen({Key? key, required this.url}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String? localPath;
  bool isLoading = true;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf(widget.url);
  }

  Future<void> _downloadAndSavePdf(String url) async {
    try {
      final response = await http.Client().send(http.Request('GET', Uri.parse(url)));
      final totalBytes = response.contentLength ?? 0;
      int downloadedBytes = 0;

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/temp.pdf');

      final bytes = <int>[];
      response.stream.listen(
            (List<int> newBytes) {
          bytes.addAll(newBytes);
          downloadedBytes += newBytes.length;
          if (mounted) {
            setState(() {
              _progress = downloadedBytes / totalBytes;
            });
          }
        },
        onDone: () async {
          await file.writeAsBytes(bytes, flush: true);
          if (mounted) {
            setState(() {
              localPath = file.path;
              isLoading = false;
            });
          }
        },
        onError: (e) {
          print("Error downloading PDF: $e");
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
        cancelOnError: true,
      );
    } catch (e) {
      print("Error downloading PDF: $e");
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: isLoading
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: LinearProgressIndicator(value: _progress),
          ),
          const SizedBox(height: 20),
          Text('${(_progress * 100).toStringAsFixed(0)}%'),
        ],
      )
          : localPath != null
          ? PDFView(
        filePath: localPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onRender: (pages) {
          setState(() {});
        },
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
      )
          : const Center(child: Text('Failed to load PDF')),
    );
  }
}
