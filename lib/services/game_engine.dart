import 'dart:math';
import '../models/user.dart';
import '../models/company.dart';
import '../models/mail.dart';
import '../models/month_summary.dart';

class GameEngine {
  static const double baseSalary = 2500.0;
  static final Random _random = Random();

  static MonthSummary processNextMonth(User user, List<Company> allCompanies) {
    double oldTotalValue = user.cash + user.calculatePortfolioValue();

    // 1. Process Saga Payouts & Chains
    double totalInvestmentPayout = 0;
    List<Mail> followUpMails = [];

    for (var investment in user.activeInvestments) {
      totalInvestmentPayout += (investment.investmentCost * investment.rewardMultiplier);
      if (investment.nextMail != null) {
        followUpMails.add(investment.nextMail!);
      }
    }
    user.activeInvestments.clear();
    user.cash += totalInvestmentPayout;

    // 2. Select a Random Mail for the Month
    Mail monthlyMail = potentialMails[_random.nextInt(potentialMails.length)];
    
    // 3. Apply Market Impact (Probability Shifting)
    if (monthlyMail is News) {
      monthlyMail.affectedCompanies.forEach((company, impact) {
        company.updateProbability(impact);
      });
    }

    // 4. Update Market Prices
    for (var company in allCompanies) {
      company.updatePrice();
    }

    // 5. Standard Monthly Finances
    user.cash += baseSalary;
    user.cash -= user.monthlyCosts;

    // 6. Manage Inbox
    for (var mail in user.inbox) {
      if (mail.isRead) mail.wasReadInPreviousMonth = true;
    }
    user.inbox.insert(0, monthlyMail);
    user.inbox.insertAll(0, followUpMails); // Follow-ups appear at top

    user.calculateNetWorth();
    double newTotalValue = user.cash + user.calculatePortfolioValue();

    return MonthSummary(
      incomeEarned: baseSalary + totalInvestmentPayout,
      expensesPaid: user.monthlyCosts,
      stockChange: user.calculatePortfolioValue(), // Update this logic as needed for your UI
      netChange: newTotalValue - oldTotalValue,
    );
  }
}