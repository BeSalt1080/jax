import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. This "Key" is like a remote control for the Scaffold
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey, // Connect the remote control here
      backgroundColor: Colors.white,

      // 2. This is the Sidebar (Drawer) definition
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFF4D4D)),
              child: Center(
                child: Text(
                  'JAX PDF',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => context.pop(), // Closes the drawer
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                context.pop(); // Close drawer
                context.push('/settings'); // Go to settings
              },
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3. We wrap "More Tools" in InkWell to make it a button that opens the drawer
              InkWell(
                onTap: () => scaffoldKey.currentState?.openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Shrinks the hit area to just the text
                    children: [
                      const Icon(Icons.menu, size: 28), // Changed icon to a menu burger
                      const SizedBox(width: 12),
                      const Text(
                        'More Tools',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildToolButton(
                    context: context,
                    icon: Icons.link,
                    label: 'Merge PDF',
                    route: '/merge',
                  ),
                  _buildToolButton(
                    context: context,
                    icon: Icons.view_column_outlined,
                    label: 'Split PDF',
                    route: '/split',
                  ),
                  _buildToolButton(
                    context: context,
                    icon: Icons.inventory_2_outlined,
                    label: 'Compress PDF',
                    route: '/compress',
                  ),
                  _buildToolButton(
                    context: context,
                    icon: Icons.swap_vert,
                    label: 'Organize PDF',
                    route: '/organize',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Center(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        contentPadding: EdgeInsets.only(left: 16, bottom: 12),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search, size: 20, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 40, 16, 20),
                child: Text(
                  'Recent',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildRecentItem(Icons.post_add),
                    _buildRecentItem(Icons.find_in_page_outlined),
                    _buildRecentItem(Icons.find_in_page_outlined),
                    _buildRecentItem(Icons.find_in_page_outlined),
                    _buildRecentItem(Icons.find_in_page_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
  }) {
    return Column(
      children: [
        Material(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () => context.go(route),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Icon(icon, size: 30, color: Colors.black87),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildRecentItem(IconData icon) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16, bottom: 10),
      child: Material(
        color: const Color(0xFFFF4D4D),
        borderRadius: BorderRadius.circular(4),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {},
          child: Center(
            child: Icon(icon, size: 60, color: Colors.black),
          ),
        ),
      ),
    );
  }
}