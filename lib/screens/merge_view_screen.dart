import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';

class MergeViewScreen extends StatefulWidget {
  final List<String>? initialPaths;

  const MergeViewScreen({super.key, this.initialPaths});

  @override
  State<MergeViewScreen> createState() => _MergeViewScreenState();
}

class _MergeViewScreenState extends State<MergeViewScreen> {
  List<String> pdfPaths = ['assets/hello.pdf'];

  @override
  void initState() {
    super.initState();
    if (widget.initialPaths != null && widget.initialPaths!.isNotEmpty) {
      pdfPaths = List.from(widget.initialPaths!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go('/'),
                    child: const Icon(Icons.arrow_back, size: 28),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Merge PDF',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
            // Render a PdfViewer for each path in pdfPaths
            Text(
              'Selected PDFs:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pdfPaths.length,
                itemBuilder: (context, index) {
                  final path = pdfPaths[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: PdfViewer.asset(path),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
