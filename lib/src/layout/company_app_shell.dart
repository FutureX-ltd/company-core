import 'package:flutter/material.dart';

import '../branding/branding_footer.dart';
import '../config/branding_config.dart';

class CompanyAppShell extends StatelessWidget {
  final Widget child;
  final BrandingConfig config;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool safeArea;

  const CompanyAppShell({
    super.key,
    required this.child,
    required this.config,
    this.appBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.safeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        Expanded(child: child),
        BrandingFooter(config: config),
      ],
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      body: safeArea ? SafeArea(child: content) : content,
    );
  }
}
