import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PoweredByLogo extends StatelessWidget {
  static const String _darkAssetPath = 'assets/logos/logo_dark.svg';
  static const String _lightAssetPath = 'assets/logos/logo_light.svg';

  final String? url;
  final bool clickable;
  final double? width;
  final double? height;

  const PoweredByLogo({
    super.key,
    this.url,
    this.clickable = true,
    this.width = 120,
    this.height = 40,
  });

  bool get _isInteractive => clickable && url != null && url!.trim().isNotEmpty;

  Future<void> _handleTap() async {
    if (!_isInteractive) {
      return;
    }

    final uri = Uri.tryParse(url!);
    if (uri == null) {
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final assetPath = brightness == Brightness.dark
        ? _darkAssetPath
        : _lightAssetPath;

    final logo = SvgPicture.asset(
      assetPath,
      package: 'company_core',
      width: width,
      height: height,
      fit: BoxFit.contain,
    );

    if (!_isInteractive) {
      return logo;
    }

    return Semantics(
      button: true,
      link: true,
      label: 'Powered by logo',
      child: InkWell(
        onTap: _handleTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(padding: const EdgeInsets.all(4), child: logo),
      ),
    );
  }
}
