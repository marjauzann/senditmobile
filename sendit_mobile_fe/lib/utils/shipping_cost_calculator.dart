enum ServiceType { reguler, express }

class ShippingCostCalculator {
  static double calculateCost({
    required double distanceKm,
    required double weightKg,
    required ServiceType serviceType,
  }) {
    if (distanceKm < 1 || weightKg < 1) {
      throw ArgumentError("Minimum jarak 1km dan berat 1kg");
    }
    if (distanceKm > 20 || weightKg > 20) {
      throw ArgumentError("Maksimum jarak 20km dan berat 20kg");
    }

    const baseCostPerKm = 5000;
    const baseCostPerKg = 2000;
    double cost = (distanceKm * baseCostPerKm) + (weightKg * baseCostPerKg);

    // Biaya tambahan berdasarkan jenis layanan dan kategori jarak
    if (serviceType == ServiceType.express) {
      if (distanceKm <= 5) {
        cost += 10000;
      } else if (distanceKm <= 10) {
        cost += 15000;
      } else if (distanceKm <= 15) {
        cost += 20000;
      } else {
        cost += 25000;
      }
    }

    return cost;
  }
}
