import 'package:flutter_test/flutter_test.dart';
import 'package:sendit/utils/shipping_cost_calculator.dart';

void main() {
  group('ShippingCostCalculator.calculateCost', () {
    // WB-01, BB-01
    test('throws error for distance < 1km or weight < 1kg', () {
      expect(
        () => ShippingCostCalculator.calculateCost(
          distanceKm: 0.9,
          weightKg: 0.9,
          serviceType: ServiceType.reguler,
        ),
        throwsArgumentError,
      );
      print('✅ Jarak < 1km dan berat < 1kg menghasilkan error sesuai ekspektasi.');
    });

    // WB-01, BB-01
    test('throws error for distance > 20km or weight > 20kg', () {
      expect(
        () => ShippingCostCalculator.calculateCost(
          distanceKm: 21,
          weightKg: 21,
          serviceType: ServiceType.reguler,
        ),
        throwsArgumentError,
      );
      print('✅ Jarak > 20km dan berat > 20kg menghasilkan error sesuai ekspektasi.');
    });

    // WB-01, BB-01
    test('calculates correct cost for regular service within valid range', () {
      final cost = ShippingCostCalculator.calculateCost(
        distanceKm: 10,
        weightKg: 10,
        serviceType: ServiceType.reguler,
      );
      print('💰 Ongkir reguler untuk 10km, 10kg: Rp$cost');
      expect(cost, 10 * 5000 + 10 * 2000);
    });

    // BB-02
    test('calculates express cost for 6-10 km', () {
      final cost = ShippingCostCalculator.calculateCost(
        distanceKm: 7,
        weightKg: 2,
        serviceType: ServiceType.express,
      );
      print('💰 Ongkir express untuk 7km, 2kg: Rp$cost');
      expect(cost, 7 * 5000 + 2 * 2000 + 15000);
    });
  });
}
