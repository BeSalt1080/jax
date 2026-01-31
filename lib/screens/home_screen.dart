import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: SizedBox(
        width: 220,
        child: Drawer(
          elevation: 0,
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Text(
                  'JAX',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1),
              ),
              const SizedBox(height: 10),
              _buildSimpleLink(context, Icons.home_filled, 'Home', '/'),
              _buildSimpleLink(context, Icons.link, 'Merge', '/merge'),
              _buildSimpleLink(context, Icons.content_cut, 'Split', '/split'),
              _buildSimpleLink(context, Icons.compress, 'Compress', '/compress'),
              _buildSimpleLink(context, Icons.layers_outlined, 'Organize', '/organize'),
              const Spacer(),
              _buildSimpleLink(context, Icons.settings_outlined, 'Settings', '/settings'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => scaffoldKey.currentState?.openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu, size: 24, color: isDark ? Colors.white : Colors.black),
                      const SizedBox(width: 12),
                      Text(
                        'More Tools',
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.w400,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildToolButton(context, Icons.link, 'Merge PDF', '/merge'),
                  _buildToolButton(context, Icons.view_column_outlined, 'Split PDF', '/split'),
                  _buildToolButton(context, Icons.inventory_2_outlined, 'Compress PDF', '/compress'),
                  _buildToolButton(context, Icons.swap_vert, 'Organize PDF', '/organize'),
                ],
              ),
              const SizedBox(height: 30),
              Divider(thickness: 1, color: isDark ? Colors.white10 : const Color(0xFFE0E0E0)),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade300),
                  ),
                  child: Center(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                        contentPadding: const EdgeInsets.only(left: 16, bottom: 12),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search, size: 20, color: isDark ? Colors.white54 : Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
                child: Text(
                  'Recent',
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
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

  Widget _buildSimpleLink(BuildContext context, IconData icon, String title, String route) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(icon, size: 20, color: isDark ? Colors.white70 : Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14, 
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      onTap: () {
        context.pop();
        context.push(route);
      },
    );
  }

  Widget _buildToolButton(BuildContext context, IconData icon, String label, String route) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Material(
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () => context.go(route),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Icon(icon, size: 30, color: isDark ? Colors.white70 : Colors.black87),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 13, 
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white70 : Colors.black,
          ),
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