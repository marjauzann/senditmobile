import 'package:flutter_test/flutter_test.dart';
import 'package:sendit/utils/payment_controller.dart';
import 'package:sendit/utils/shipping_cost_calculator.dart';
void main() {
  group('PaymentController.validatePaymentMethod', () {
    final premiumUser = User(isPremium: true);
    final regularUser = User(isPremium: false);
// WB-02 — COD user reguler, <= 150rb (diperbolehkan)
    test('WB-02: COD allowed for regular user if <= 150k', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 100000,
        method: PaymentMethod.cod,
        user: regularUser,
      );
      print('WB-02 ✅ COD 100rb user reguler: $result');
      expect(result, isTrue);
    });

    // WB-02 — COD user reguler, > 150rb (ditolak)
    test('WB-02: COD not allowed for regular user if > 150k', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 200000,
        method: PaymentMethod.cod,
        user: regularUser,
      );
      print('WB-02 ❌ COD 200rb user reguler: $result');
      expect(result, isFalse);
    });

    // WB-02 — COD user premium, > 150rb (diperbolehkan)
    test('WB-02: COD allowed for premium user regardless of amount', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 500000,
        method: PaymentMethod.cod,
        user: premiumUser,
      );
      print('WB-02 ✅ COD 500rb user premium: $result');
      expect(result, isTrue);
    });

    // WB-02 — Transfer, nilai kecil (selalu diperbolehkan)
    test('WB-02: Transfer is always allowed, even small amount', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 10000,
        method: PaymentMethod.transfer,
        user: regularUser,
      );
      print('WB-02 ✅ Transfer 10rb user reguler: $result');
      expect(result, isTrue);
    });

    // WB-02 — E-wallet, ≤ 300rb (valid)
    test('WB-02: E-wallet allowed if amount <= 300k', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 300000,
        method: PaymentMethod.eWallet,
        user: regularUser,
      );
      print('WB-02 ✅ E-wallet 300rb: $result');
      expect(result, isTrue);
    });

    // WB-02 — E-wallet, > 300rb (invalid)
    test('WB-02: E-wallet not allowed if amount > 300k', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 350000,
        method: PaymentMethod.eWallet,
        user: regularUser,
      );
      print('WB-02 ❌ E-wallet 350rb: $result');
      expect(result, isFalse);
    });
    
    // BB-03
    test('COD not allowed for amount > 150k for regular user', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 200000,
        method: PaymentMethod.cod,
        user: regularUser,
      );
      print('🔍 Validasi COD 200rb user reguler: $result');
      expect(result, isFalse);
    });

    // BB-03
    test('COD allowed for premium user regardless of amount', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 500000,
        method: PaymentMethod.cod,
        user: premiumUser,
      );
      print('🔍 Validasi COD 500rb user premium: $result');
      expect(result, isTrue);
    });

    // BB-03
    test('eWallet not allowed if amount > 300k', () {
      final result = PaymentController.validatePaymentMethod(
        amount: 350000,
        method: PaymentMethod.eWallet,
        user: regularUser,
      );
      print('🔍 Validasi eWallet 350rb: $result');
      expect(result, isFalse);
    });

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
  });});
}
