enum PaymentMethod { cod, transfer, eWallet }

class User {
  final bool isPremium;

  User({required this.isPremium});
}

class PaymentController {
  static bool validatePaymentMethod({
    required double amount,
    required PaymentMethod method,
    required User user,
  }) {
    if (method == PaymentMethod.cod) {
      if (user.isPremium) return true;
      return amount <= 150000;
    }

    if (method == PaymentMethod.transfer) {
      return true; // always allowed
    }

    if (method == PaymentMethod.eWallet) {
      return amount <= 300000;
    }

    return false;
  }
}
