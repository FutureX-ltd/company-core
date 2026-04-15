import 'package:flutter/material.dart';

import '../config/branding_config.dart';
import 'powered_by_logo.dart';

const _defaultBrandingConfig = BrandingConfig(
  showPoweredBy: true,
  clickable: true,
  url: 'https://futurex.com',
  text: 'Powered by',
  showText: false,
  logoWidth: 90,
  logoHeight: 24,
);

class BrandingFooter extends StatelessWidget {
  final BrandingConfig? config;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  const BrandingFooter({
    super.key,
    this.config,
    this.width = 120,
    this.height = 40,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveConfig = config ?? _defaultBrandingConfig;

    if (!effectiveConfig.showPoweredBy) {
      return const SizedBox.shrink();
    }

    final logoWidth = config == null ? effectiveConfig.logoWidth : width;
    final logoHeight = config == null ? effectiveConfig.logoHeight : height;
    final showText =
        effectiveConfig.showText && effectiveConfig.text.isNotEmpty;

    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showText)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  effectiveConfig.text,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            PoweredByLogo(
              url: effectiveConfig.url,
              clickable: effectiveConfig.clickable,
              width: logoWidth,
              height: logoHeight,
            ),
          ],
        ),
      ),
    );
  }
}
