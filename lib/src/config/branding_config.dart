class BrandingConfig {
  final bool showPoweredBy;
  final bool clickable;
  final String? url;
  final String text;
  final bool showText;
  final double logoWidth;
  final double logoHeight;

  const BrandingConfig({
    this.showPoweredBy = true,
    this.clickable = true,
    this.url,
    this.text = 'Powered by',
    this.showText = false,
    this.logoWidth = 120,
    this.logoHeight = 40,
  });
}
