import '../models/user.dart';
import '../models/company.dart';
import '../models/month_summary.dart';

class GameEngine {
  static const double baseSalary = 2500.0;

  static MonthSummary processNextMonth(User user, List<Company> companies) {
    // 1. Capture snapshots for the summary report
    double oldPortfolioValue = user.calculatePortfolioValue();

    // 2. Archive Inbox: Anything read this month moves to "Past Mail" next month
    for (var mail in user.inbox) {
      if (mail.isRead) {
        mail.wasReadInPreviousMonth = true;
      }
    }

    // 3. Process User Finances
    user.cash += baseSalary;
    user.cash -= user.monthlyCosts;

    // 4. Update Market Prices
    for (var company in companies) {
      company.updatePrice();
    }
    user.calculateNetWorth();

    // 5. Calculate final summary data
    double newPortfolioValue = user.calculatePortfolioValue();
    double stockChange = newPortfolioValue - oldPortfolioValue;

    return MonthSummary(
      incomeEarned: baseSalary,
      expensesPaid: user.monthlyCosts,
      stockChange: stockChange,
      netChange: (baseSalary - user.monthlyCosts) + stockChange,
    );
  }
}