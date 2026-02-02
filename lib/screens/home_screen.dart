import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showTip = true;
  List<String> _recentFiles = ['Report_Q4.pdf', 'Contract_Signed.pdf', 'Design_Spec.pdf'];

  Future<void> _handleFileSelection() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && mounted) {
      _showSmartActionMenu(result.files);
    }
  }

  void _showSmartActionMenu(List<PlatformFile> files) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isMultiple = files.length > 1;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMultiple ? '${files.length} Files Selected' : files.first.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('What would you like to do?', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 16),
            if (isMultiple)
              _buildActionButton(context, Icons.link, 'Merge these files', '/merge')
            else ...[
              _buildActionButton(context, Icons.compress, 'Compress file', '/compress'),
              _buildActionButton(context, Icons.content_cut, 'Split into parts', '/split'),
              _buildActionButton(context, Icons.layers_outlined, 'Organize pages', '/organize'),
            ],
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: _buildThinnerSidebar(context, isDark),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isDark),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Divider(thickness: 1)),
                Expanded(
                  child: Center(
                    child: Container(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSearchBar(isDark),
                            const SizedBox(height: 32),
                            _buildHeroUploadArea(isDark),
                            const SizedBox(height: 32),
                            _buildSectionHeader('FAVORITES', isDark),
                            const SizedBox(height: 12),
                            _buildPinnedTools(context, isDark),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSectionHeader('RECENT ACTIVITY', isDark),
                                if (_recentFiles.isNotEmpty)
                                  TextButton(
                                    onPressed: () => setState(() => _recentFiles.clear()),
                                    child: const Text('Clear', style: TextStyle(fontSize: 11, color: Color(0xFFFF4D4D))),
                                  ),
                              ],
                            ),
                            _buildRecentList(isDark),
                            const SizedBox(height: 60),
                            _buildPrivacyBadge(isDark),
                            const SizedBox(height: 100), // Space for tooltip
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_showTip) _buildFloatingTooltip(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: Icon(Icons.menu, color: isDark ? Colors.white : Colors.black),
          ),
          const SizedBox(width: 8),
          const Text('JAX PDF', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 14, color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          hintText: 'Search tools or files...',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, size: 18, color: isDark ? Colors.white54 : Colors.black54),
        ),
      ),
    );
  }

  Widget _buildHeroUploadArea(bool isDark) {
    return Material(
      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF9F9F9),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: _handleFileSelection,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              const Icon(Icons.add_circle_outline, size: 48, color: Color(0xFFFF4D4D)),
              const SizedBox(height: 16),
              const Text('Select or Drop PDF', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text('Your files stay private & local', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinnedTools(BuildContext context, bool isDark) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _toolChip(context, Icons.link, 'Merge', '/merge', isDark),
        _toolChip(context, Icons.compress, 'Compress', '/compress', isDark),
        _toolChip(context, Icons.content_cut, 'Split', '/split', isDark),
        _toolChip(context, Icons.layers_outlined, 'Organize', '/organize', isDark),
      ],
    );
  }

  Widget _toolChip(BuildContext context, IconData icon, String label, String route, bool isDark) {
    return Material(
      color: isDark ? const Color(0xFF2C2C2C) : Colors.black,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () => context.push(route),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentList(bool isDark) {
    if (_recentFiles.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text('No recent activity', style: TextStyle(color: Colors.grey, fontSize: 12)),
      );
    }
    return Column(
      children: _recentFiles.map((file) => _recentItem(file, isDark)).toList(),
    );
  }

  Widget _recentItem(String name, bool isDark) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.picture_as_pdf, color: Color(0xFFFF4D4D), size: 24),
      title: Text(name, style: const TextStyle(fontSize: 13)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildPrivacyBadge(bool isDark) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shield_outlined, size: 14, color: Colors.grey),
            const SizedBox(width: 8),
            Text('Bank-level privacy. Files never leave your device.', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingTooltip(bool isDark) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2C) : Colors.black,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('PRO TIP', style: TextStyle(color: Color(0xFFFF4D4D), fontSize: 10, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => setState(() => _showTip = false),
                  child: const Icon(Icons.close, color: Colors.white54, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Select multiple files at once to use the Merge tool automatically.',
              style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFF4D4D)),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: () {
        context.pop();
        context.push(route);
      },
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? Colors.white38 : Colors.black38, letterSpacing: 1.5));
  }

  Widget _buildThinnerSidebar(BuildContext context, bool isDark) {
    return SizedBox(
      width: 240, // Slightly wider for better text fit
      child: Drawer(
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BRANDING HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'JAX',
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold, 
                      letterSpacing: 3,
                    ),
                  ),
                  Text(
                    'PDF WORKSPACE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF4D4D),
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Divider(thickness: 1),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  // SECTION: GENERAL
                  _buildSidebarHeader('WORKSPACE'),
                  _sideLink(context, Icons.home_filled, 'Dashboard', '/'),
                  _sideLink(context, Icons.history, 'Recent Files', '/'), // Link to recent section
                  
                  const SizedBox(height: 20),
                  
                  // SECTION: TOOLS
                  _buildSidebarHeader('PDF TOOLS'),
                  _sideLink(context, Icons.link, 'Merge PDF', '/merge'),
                  _sideLink(context, Icons.content_cut, 'Split PDF', '/split'),
                  _sideLink(context, Icons.compress, 'Compress PDF', '/compress'),
                  _sideLink(context, Icons.layers_outlined, 'Organize PDF', '/organize'),
                  
                  const SizedBox(height: 20),
                  
                  // SECTION: CONVERT (Placeholder for future)
                  _buildSidebarHeader('CONVERT'),
                  _sideLink(context, Icons.picture_as_pdf_outlined, 'PDF to Word', '/', isDisabled: true),
                  _sideLink(context, Icons.image_outlined, 'Image to PDF', '/', isDisabled: true),
                ],
              ),
            ),

            // FOOTER SECTION
            const Divider(thickness: 1),
            _sideLink(context, Icons.settings_outlined, 'Settings', '/settings'),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
              child: Text(
                'v 1.0.0',
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? Colors.white24 : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Sidebar Headers
  Widget _buildSidebarHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  // Helper for Sidebar Links
  Widget _sideLink(BuildContext context, IconData icon, String title, String route, {bool isDisabled = false}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListTile(
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      enabled: !isDisabled,
      leading: Icon(
        icon, 
        size: 18, 
        color: isDisabled 
            ? Colors.grey.withOpacity(0.3) 
            : (isDark ? Colors.white70 : Colors.black87),
      ),
      title: Text(
        title, 
        style: TextStyle(
          fontSize: 13, 
          fontWeight: FontWeight.w500,
          color: isDisabled 
              ? Colors.grey.withOpacity(0.3) 
              : (isDark ? Colors.white : Colors.black),
        ),
      ),
      onTap: isDisabled ? null : () {
        context.pop(); // Close drawer
        context.push(route);
      },
    );
  }
}