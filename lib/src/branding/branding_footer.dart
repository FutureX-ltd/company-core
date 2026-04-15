import 'package:flutter/material.dart';

import '../config/branding_config.dart';
import 'powered_by_logo.dart';

const _defaultBrandingConfig = BrandingConfig(
  showPoweredBy: true,
  clickable: true,
  url: 'https://futxtech.com/',
  text: 'Powered by',
  showText: true,
  logoWidth: 76,
  logoHeight: 24,
);

class BrandingFooter extends StatelessWidget {
  final BrandingConfig? config;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;

  const BrandingFooter({
    super.key,
    this.config,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveConfig = config ?? _defaultBrandingConfig;

    if (!effectiveConfig.showPoweredBy) {
      return const SizedBox.shrink();
    }

    final logoWidth = width ?? effectiveConfig.logoWidth;
    final logoHeight = height ?? effectiveConfig.logoHeight;
    final showText =
        effectiveConfig.showText && effectiveConfig.text.isNotEmpty;

    return Padding(
      padding: padding,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showText)
              Text(
                effectiveConfig.text,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            if (showText) const SizedBox(width: 8),
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
