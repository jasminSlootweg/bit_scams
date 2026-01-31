import 'company.dart';
import 'mail.dart';

class User {
  String name;
  double cash;
  double rent, groceries, transportation, carInsurance, otherExpenses;
  
  Map<Company, int> portfolio = {};
  List<Mail> inbox = []; 
  
  double netWorth = 0.0;
  int debtStrikes = 0;

  User({
    required this.name,
    required this.cash,
    required this.rent,
    required this.groceries,
    required this.transportation,
    required this.carInsurance,
    this.otherExpenses = 0.0,
  }) {
    // Default Welcome Email
    inbox.add(News(
      subject: 'Welcome to Scam Life!',
      body: 'Your inbox delivers newsletters and insights. Watch out for scams!',
      affectedCompanies: {},
    ));
    calculateNetWorth();
  }

  double get monthlyCosts => rent + groceries + transportation + carInsurance + otherExpenses;

  double calculatePortfolioValue() {
    double total = 0.0;
    portfolio.forEach((company, shares) => total += company.price * shares);
    return total;
  }

  void calculateNetWorth() {
    netWorth = cash + calculatePortfolioValue();
  }

  void buyStock(Company company, int shares) {
    double cost = company.price * shares;
    if (cash >= cost) {
      cash -= cost;
      portfolio[company] = (portfolio[company] ?? 0) + shares;
      calculateNetWorth();
    }
  }

  void sellStock(Company company, int shares) {
    int currentShares = portfolio[company] ?? 0;
    if (currentShares >= shares) {
      cash += company.price * shares;
      portfolio[company] = currentShares - shares;
      if (portfolio[company] == 0) portfolio.remove(company);
      calculateNetWorth();
    }
  }
}