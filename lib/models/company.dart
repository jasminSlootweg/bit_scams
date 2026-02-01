import 'dart:math';

enum RiskLevel { low, medium, high }

class Company {
  final String name;
  final String sector;
  final String description;
  final String longDescription;
  final RiskLevel risk;

  double price;
  int owned;
  bool goingUp;

  double probabilityModifier;
  List<double> priceHistory;
  double lastChangePercent;

  final Random _random = Random();

  Company({
    required this.name,
    required this.sector,
    required this.description,
    required this.longDescription,
    this.risk = RiskLevel.medium,
    this.price = 50,
    this.owned = 0,
    this.goingUp = true,
    this.probabilityModifier = 0.0,
    List<double>? initialPriceHistory,
  }) : 
        priceHistory = initialPriceHistory ??
            [
              double.parse(
                (price * (1 + _getInitialFluctuation(risk, Random()))).toStringAsFixed(2),
              )
            ],
        lastChangePercent = 0.0;

  static double _getInitialFluctuation(RiskLevel risk, Random random) {
    double maxFluctuation;
    switch (risk) {
      case RiskLevel.low: maxFluctuation = 0.03; break;
      case RiskLevel.medium: maxFluctuation = 0.07; break;
      case RiskLevel.high: maxFluctuation = 0.15; break;
    }
    return random.nextDouble() * 2 * maxFluctuation - maxFluctuation;
  }

  void updateProbability(double change) {
    probabilityModifier += change;
    probabilityModifier = probabilityModifier.clamp(-1.0, 1.0);
  }

  void updatePrice() {
    priceHistory.insert(0, price);

    double baseProbability;
    switch (risk) {
      case RiskLevel.low: baseProbability = 0.55; break;
      case RiskLevel.medium: baseProbability = 0.5; break;
      case RiskLevel.high: baseProbability = 0.45; break;
    }

    double finalProbability = (baseProbability + probabilityModifier).clamp(0.0, 1.0);
    goingUp = _random.nextDouble() < finalProbability;

    double volatility;
    switch (risk) {
      case RiskLevel.low: volatility = 0.03; break;
      case RiskLevel.medium: volatility = 0.07; break;
      case RiskLevel.high: volatility = 0.15; break;
    }

    double changePercent = _random.nextDouble() * volatility;
    price *= goingUp ? (1 + changePercent) : (1 - changePercent);
    price = double.parse(price.toStringAsFixed(2));

    if (priceHistory.isNotEmpty) {
      lastChangePercent = double.parse((((price - priceHistory.first) / priceHistory.first) * 100).toStringAsFixed(2));
    }
  }
}

