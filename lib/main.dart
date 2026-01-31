import 'package:flutter/material.dart';
import 'router/app_router.dart';

void main() {
  runApp(const JaxApp());
}

class JaxApp extends StatelessWidget {
  const JaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Jax',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
