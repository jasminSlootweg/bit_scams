import 'company.dart';

abstract class Mail {
  final String subject;
  final String body;
  bool isRead;
  bool wasReadInPreviousMonth;

  Mail({
    required this.subject,
    required this.body,
    this.isRead = false,
    this.wasReadInPreviousMonth = false,
  });
}

class News extends Mail {
  final Map<Company, double> affectedCompanies;

  News({
    required super.subject,
    required super.body,
    required this.affectedCompanies,
    super.isRead,
    super.wasReadInPreviousMonth,
  });
}

class Offer extends Mail {
  final double investmentCost;
  final bool isScam;
  final double rewardMultiplier;
  final Mail? nextMail;

  Offer({
    required super.subject,
    required super.body,
    required this.investmentCost,
    required this.isScam,
    required this.rewardMultiplier,
    this.nextMail,
    super.isRead,
    super.wasReadInPreviousMonth,
  });
}
