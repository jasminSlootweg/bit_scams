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

// ---------- SAGA FOLLOW-UPS (Defined First) ----------

final News ponziBusted = News(
  subject: "Financial Crime Alert: RapidWealth Circle Shut Down",
  body: "Global Finance News Report\n\nAuthorities have shut down an investment operation known as RapidWealth Circle, describing it as a large Ponzi scheme. Investigators say the company promised unrealistic profits and used money from new investors to pay earlier participants.\n\nThe group had no real trading system or business activity. Millions of dollars are believed to be lost. Officials warn the public to be cautious of offers guaranteeing high or risk-free returns.",
  affectedCompanies: {},
);

final News horizonUpdate = News(
  subject: "Monthly Portfolio Update & Performance Summary",
  body: "Dear Investor,\n\nHere is your latest monthly portfolio update. Over the past month, your Balanced Growth Portfolio returned 0.48%. Market conditions were relatively stable, with small gains in infrastructure and large company stocks balancing minor declines in other areas. Your return has been deposited into your cash account.",
  affectedCompanies: {},
);

final Offer ponziFollowUp = Offer(
  subject: "Your First Profit Payment Has Arrived!",
  body: "Dear Valued Investor,\n\nCongratulations! Your investment with RapidWealth Circle is already working. Based on our trading activity, you have earned \$480 in profit this week. Many members choose to reinvest their profits to unlock even larger gains next month.\n\nReinvest \$500 now and maximize your earnings.",
  investmentCost: 500.0,
  isScam: true,
  rewardMultiplier: 2.0,
  nextMail: ponziBusted,
);

// ---------- SAGA OPENERS & ONE-OFFS ----------

final Offer ponziOpening = Offer(
  subject: "Turn \$500 Into \$10,000 in Just 30 Days!",
  body: "Dear Investor,\n\nA private group of market experts has unlocked a secret trading system that guarantees massive returns. Our members are seeing profits of 32% in one month, and now you’re invited!\n\nAll you need to do is invest \$1,500 today. Early investors are already receiving checks by mail every week!",
  investmentCost: 1500.0,
  isScam: true,
  rewardMultiplier: 1.32,
  nextMail: ponziFollowUp,
);

final Offer horizonOpening = Offer(
  subject: "Balanced Growth Portfolio – Long-Term Investment Opportunity",
  body: "Dear Investor,\n\nWe’re offering access to our Balanced Growth Portfolio, designed for steady, long-term returns rather than quick profits. Our goal is an average return of 5–7% per year over time.",
  investmentCost: 2000.0,
  isScam: false,
  rewardMultiplier: 1.0048,
  nextMail: horizonUpdate,
);

final Offer nigerianPrince = Offer(
  subject: "URGENT BUSINESS ASSISTANCE",
  body: "Dear Trusted Friend,\n\nI am a royal family member seeking your help to transfer \$18 million out of my country. If you allow us to use your bank account for this safe transfer, you will receive 30% of the total amount as a reward.",
  investmentCost: 3000.0,
  isScam: true,
  rewardMultiplier: 0.0,
);

// ---------- WORLD EVENTS ----------

final News pandemicEvent = News(
  subject: "Global Health Advisory: New Viral Illness Spreading",
  body: "Health agencies report the spread of a newly identified viral disease across multiple regions. Hospitals are monitoring rising patient numbers.",
  affectedCompanies: {
    brightPulse: 0.25, viraCure: 0.40, safeLink: 0.15,
    pixelTrail: 0.20, homeBot: 0.10, trailGuard: -0.25,
    cityCycle: -0.20, petalPatch: -0.15,
  },
);

final News bearMarketEvent = News(
  subject: "Global Markets Experience Continued Decline",
  body: "Financial markets around the world are trending downward as economic uncertainty increases.",
  affectedCompanies: {
    brightPulse: 0.05, windWay: 0.05, earthCore: -0.10,
    cozyNest: -0.25, pixelTrail: -0.30, homeBot: -0.35,
    silverStream: -0.20, greenFrame: -0.15,
  },
);

final News bullMarketEvent = News(
  subject: "Global Markets Rally as Economic Confidence Grows",
  body: "Financial markets worldwide are rising as economic confidence improves. Consumer spending reports show increased activity.",
  affectedCompanies: {
    pixelTrail: 0.30, homeBot: 0.35, cozyNest: 0.25,
    greenFrame: 0.20, silverStream: 0.20, brightPulse: 0.10, windWay: 0.15,
  },
);

// Note: Removed '+' from all double values to fix the InvalidType error
final News techTaxEvent = News(
  subject: "Governments Announce Updated Tax Rules for Technology Firms",
  body: "Several governments have introduced new tax regulations aimed at large technology companies operating across borders.",
  affectedCompanies: {
    safeLink: -0.10, pixelTrail: -0.15, homeBot: -0.12,
    holoLife: -0.18, numberNest: 0.25,
  },
);

// ... (Other pitch News items: holoLifePitch, greenFramePitch, etc.)

// ---------- MASTER SELECTION LIST ----------

final List<Mail> potentialMails = [
  ponziOpening,
  horizonOpening,
  nigerianPrince,
  pandemicEvent,
  bearMarketEvent,
  techTaxEvent,
  bullMarketEvent,
];