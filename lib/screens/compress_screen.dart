import 'package:flutter/material.dart';

class CompressScreen extends StatelessWidget {
  const CompressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compress PDF')),
      body: const Center(child: Text('Compress PDF screen')),
    );
  }
}
