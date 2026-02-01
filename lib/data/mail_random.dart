import '../models/mail.dart';
import '../models/company.dart';
import 'company_data.dart'; 

// ---------- SPECIAL MAILS ----------

final News welcomeEmail = News(
  subject: 'Welcome to your Inbox!',
  body: 'Welcome to the inbox! Here is where you will see updates about the world through a newsletter that will impact stocks for the next few months.\n\nIt is also where you can get some amazing investment opportunities... or scams! Read carefully!',
  affectedCompanies: {},
);

// ---------- SAGA FOLLOW-UPS  ----------

final News ponziBusted = News(
  subject: "Financial Crime Alert: RapidWealth Circle Shut Down",
  body: "Authorities have shut down RapidWealth Circle, describing it as a large Ponzi scheme. Millions of dollars are believed to be lost. Your account has been flagged for investigation.",
  affectedCompanies: {},
);

final News horizonUpdate = News(
  subject: "Monthly Portfolio Update",
  body: "Your Balanced Growth Portfolio returned 0.48% this month. The return has been deposited into your cash account.",
  affectedCompanies: {},
);

final Offer ponziFollowUp = Offer(
  subject: "Your First Profit Payment Has Arrived!",
  body: "Congratulations! Your investment is working. Reinvest \$500 now to maximize your earnings.",
  investmentCost: 500.0,
  isScam: true,
  rewardMultiplier: 2.0, 
  nextMail: ponziBusted,
);

// ---------- SAGA OPENERS ----------

final Offer ponziOpening = Offer(
  subject: "Turn \$1,500 Into \$20,000!",
  body: "A secret trading system guarantees massive returns. Invest \$1,500 today to secure your spot!",
  investmentCost: 1500.0,
  isScam: true,
  rewardMultiplier: 1.20, 
  nextMail: ponziFollowUp,
);

final Offer horizonOpening = Offer(
  subject: "Balanced Growth Portfolio",
  body: "Steady, long-term returns. Our goal is 5-7% per year. Licensed professional management. One-time entry fee.",
  investmentCost: 2000.0,
  isScam: false,
  rewardMultiplier: 1.05, 
  nextMail: horizonUpdate,
);

final Offer nigerianPrince = Offer(
  subject: "URGENT BUSINESS ASSISTANCE",
  body: "I am a royal family member seeking help to transfer \$18 million. We require a \$3,000 'processing fee' to release the funds.",
  investmentCost: 3000.0,
  isScam: true,
  rewardMultiplier: 0.0,
);

// ---------- WORLD EVENTS (NEWS) ----------

final News pandemicEvent = News(
  subject: "Global Health Advisory",
  body: "A new viral illness is spreading. Markets are reacting with fear, though tech and pharma are seeing unusual activity.",
  affectedCompanies: {
    // pharmaCo: 0.2, 
    // techGiant: 0.1,
    // airlines: -0.4,
  },
);

final News techCrash = News(
  subject: "Tech Bubble Burst?",
  body: "Major software firms report lower-than-expected earnings. Investors are fleeing high-growth stocks.",
  affectedCompanies: {},
);

final News bullMarketEvent = News(
  subject: "Global Markets Rally",
  body: "Economic confidence grows as consumer spending increases worldwide. Everything is green!",
  affectedCompanies: {},
);

final News cryptoHype = News(
  subject: "Digital Asset Surge",
  body: "A new wave of interest in digital currencies is driving speculative fever. High volatility expected.",
  affectedCompanies: {},
);
final Offer cryptoPhish = Offer(
  subject: "Security Breach: Action Required",
  body: "Our records show an unauthorized login to your digital wallet. Deposit \$400 into our 'Security Escrow' to protect your assets.",
  investmentCost: 400.0,
  isScam: true,
  rewardMultiplier: 0.0, // Pure loss
);

final News savingsMaturity = News(
  subject: "CD Account Matured",
  body: "Your 3-month Certificate of Deposit has matured. Your principal and interest have been returned.",
  affectedCompanies: {},
);

final Offer bankCD = Offer(
  subject: "Secure Your Savings",
  body: "Open a high-yield Certificate of Deposit. 3% guaranteed return over 3 months. Zero risk.",
  investmentCost: 5000.0,
  isScam: false,
  rewardMultiplier: 1.03,
  nextMail: savingsMaturity,
);

//LOAN SCAM
final News loanPaymentDue = News(
  subject: "Loan Repayment Final Notice",
  body: "The interest on your short-term loan has accrued. \$1,200 has been deducted from your account.",
  affectedCompanies: {},
);

final Offer paydayLoan = Offer(
  subject: "Need Cash Fast? \$1,000 Instant Deposit!",
  body: "No credit check required. Get \$1,000 today! (Terms: Total repayment of \$1,200 due next month).",
  investmentCost: -1000.0, 
  isScam: false, 
  rewardMultiplier: -1.2, 
  nextMail: loanPaymentDue,
);

//FINE ART SCAM
final News artBust = News(
  subject: "Masterpiece Gallery Vanishes",
  body: "The online portal for 'Masterpiece Gallery' has gone offline. Investors fear a 'rug pull' as the company's founders have deleted their social media profiles.",
  affectedCompanies: {},
);

final Offer artFractional = Offer(
  subject: "Own a Picasso for \$2,000!",
  body: "Why buy a whole painting when you can buy a share? Our fractional ownership model guarantees a 15% increase in value as the art market heats up.",
  investmentCost: 2000.0,
  isScam: true,
  rewardMultiplier: 0.0, 
  nextMail: artBust,
);

//INHERITANCE SCAM
final Offer inheritanceScam = Offer(
  subject: "Legal Notice: Unclaimed Estate",
  body: "We have identified you as the sole beneficiary of an estate valued at \$4.2 Million. To begin the transfer, a mandatory 'Overseas Tax' of \$4,500 must be paid to the High Court.",
  investmentCost: 4500.0,
  isScam: true,
  rewardMultiplier: 0.0, // Total loss
);

//Influencer Course Scam
final News courseUseless = News(
  subject: "Course Review: Alpha Trader Academy",
  body: "Users are reporting that the \$1,200 'Alpha Trader' course contains only basic information available for free on Wikipedia. Refund requests are being denied.",
  affectedCompanies: {},
);

final Offer influencerCourse = Offer(
  subject: "QUIT YOUR JOB IN 30 DAYS",
  body: "I've made millions trading stocks from my bathtub. My 'Alpha Trader' course normally costs \$5,000, but for the next 24 hours, it's yours for \$1,200!",
  investmentCost: 1200.0,
  isScam: true,
  rewardMultiplier: 0.1, // You get back \$120, losing \$1,080
  nextMail: courseUseless,
);

// ---------- MASTER LIST ----------

final List<Mail> potentialMails = [
  // --- Saga Openers (Offer) ---
  ponziOpening,      // The 2-stage Ponzi scheme
  horizonOpening,    // The legit Balanced Growth Portfolio
  artFractional,     // The "Masterpiece Gallery" rug pull
  influencerCourse,  // The "Alpha Trader Academy" scam
  paydayLoan,        // The predatory (but legit) loan trap
  bankCD,            // The safe, low-interest bank deposit

  // --- Standalone Scams (Offer) ---
  nigerianPrince,    // High-cost, zero-reward classic
  inheritanceScam,   // The "Unclaimed Estate" tax scam
  cryptoPhish,       // The "Security Breach" wallet drainer

  // --- World Events (News) ---
  pandemicEvent,     // Impacts Pharma/Tech/Airlines
  bullMarketEvent,   // General market boost
  techCrash,         // Specific tech sector hit
  cryptoHype,        // Increases market volatility
];