import 'package:flutter/material.dart';
import 'router/app_router.dart';

void main() {
  runApp(const JaxApp());
}

class JaxApp extends StatelessWidget {
  const JaxApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Jax',
          themeMode: currentMode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            colorSchemeSeed: const Color(0xFFFF4D4D),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            colorSchemeSeed: const Color(0xFFFF4D4D),
          ),
          routerConfig: appRouter,
        );
      },
    );
  }
}