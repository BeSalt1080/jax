import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(thickness: 1),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildSettingHeader('APPEARANCE'),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w500)),
                    trailing: Switch(
                      activeThumbColor: const Color(0xFFFF4D4D),
                      value: isDark,
                      onChanged: (val) => JaxApp.themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSettingHeader('APPLICATION'),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('App Version', style: TextStyle(fontWeight: FontWeight.w500)),
                    trailing: const Text('1.0.0', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}