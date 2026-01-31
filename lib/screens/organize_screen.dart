import 'package:flutter/material.dart';

class OrganizeScreen extends StatelessWidget {
  const OrganizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organize PDF')),
      body: const Center(child: Text('Organize PDF screen')),
    );
  }
}
