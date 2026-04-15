import 'package:flutter/material.dart';

import '../config/branding_config.dart';
import 'powered_by_logo.dart';

class BrandingFooter extends StatelessWidget {
  final BrandingConfig config;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  const BrandingFooter({
    super.key,
    required this.config,
    this.width = 120,
    this.height = 40,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    if (!config.showPoweredBy) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: padding,
      child: Center(
        child: PoweredByLogo(
          url: config.url,
          clickable: config.clickable,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
