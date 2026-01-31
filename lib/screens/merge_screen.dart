import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jax/services/pdf_services.dart';

class MergeScreen extends StatelessWidget {
  const MergeScreen({super.key});

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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () async {
                          final paths = await mergeProcess();
                          if (paths != null && paths.isNotEmpty) {
                            context.go('/merge-view', extra: paths);
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 250,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_circle_outline, size: 50, color: Colors.black54),
                              const SizedBox(height: 16),
                              Text(
                                'Select PDF files',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'or drop PDFs here',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                color: const Color(0xFFFF4D4D),
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  onTap: () async {
                    final paths = await mergeProcess();
                    if (paths != null && paths.isNotEmpty) {
                      context.go('/merge-view', extra: paths);
                    }
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    alignment: Alignment.center,
                    child: const Text(
                      'Merge PDF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}