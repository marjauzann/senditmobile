import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Sendit App', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('Hitung ongkos kirim', () async {
      // Find text fields
      final distanceField = find.byValueKey('distanceField');
      final weightField = find.byValueKey('weightField');
      final calculateButton = find.byValueKey('calculateButton');

      // Interact with UI
      await driver.tap(distanceField);
      await driver.enterText('5.0');
      await driver.tap(weightField);
      await driver.enterText('3.0');
      await driver.tap(calculateButton);

      // Verify results
      expect(await driver.getText(find.byValueKey('resultText')), 
             contains('Rp21.500'));
    });
  });
}