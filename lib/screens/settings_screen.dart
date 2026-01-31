import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back, size: 28),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Appearance', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.palette_outlined),
                    title: const Text('Theme Mode'),
                    subtitle: const Text('System Default'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // We will add the logic to switch themes here later
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.color_lens_outlined),
                    title: const Text('Primary Color'),
                    subtitle: const Text('Jax Red'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('About', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Version'),
                    trailing: const Text('1.0.0'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}