import 'package:company_core/company_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BrandingConfig', () {
    test('uses sensible defaults', () {
      const config = BrandingConfig();

      expect(config.showPoweredBy, isTrue);
      expect(config.clickable, isTrue);
      expect(config.url, isNull);
      expect(config.text, 'Powered by');
      expect(config.showText, isTrue);
      expect(config.logoWidth, 76);
      expect(config.logoHeight, 24);
    });
  });
}
