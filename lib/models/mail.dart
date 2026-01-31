import 'company.dart';

abstract class Mail {
  final String subject;
  final String body;
  bool isRead;
  // This is the missing field causing your error
  bool wasReadInPreviousMonth; 

  Mail({
    required this.subject,
    required this.body,
    this.isRead = false,
    this.wasReadInPreviousMonth = false,
  });
}

// ---------- SUBCLASS: NEWS ----------

class News extends Mail {
  final Map<Company, double> affectedCompanies;

  News({
    required super.subject,
    required super.body,
    required this.affectedCompanies,
    super.isRead,
    super.wasReadInPreviousMonth, // Pass through to parent
  });
}

// ---------- SUBCLASS: OFFERS ----------

class Offer extends Mail {
  final double investmentCost;
  final bool isScam;
  final double rewardMultiplier;

  Offer({
    required super.subject,
    required super.body,
    required this.investmentCost,
    required this.isScam,
    required this.rewardMultiplier,
    super.isRead,
    super.wasReadInPreviousMonth, // Pass through to parent
  });
}