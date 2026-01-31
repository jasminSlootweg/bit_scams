import 'company.dart';
import 'mail.dart';

class User {
  String name;
  double cash;
  double rent, groceries, transportation, carInsurance, otherExpenses;
  
  Map<Company, int> portfolio = {};
  List<Mail> inbox = []; 
  List<Offer> activeInvestments = []; 

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
    inbox.add(News(
      subject: 'Welcome to your Inbox!',
      body: 'Welcome to the inbox! Here is where you will see updates about the world through a newsletter that will impact stocks for the next few months.\n\nIt is also where you can get some amazing investment opportunities... or scams! Read carefully!',
      affectedCompanies: {},
    ));
    calculateNetWorth();
  }

  double get monthlyCosts => rent + groceries + transportation + carInsurance + otherExpenses;

  // --- Financial Calculations ---

  void calculateNetWorth() {
    double portfolioValue = 0.0;
    portfolio.forEach((company, shares) => portfolioValue += company.price * shares);
    netWorth = cash + portfolioValue;
  }

  double calculatePortfolioValue() {
    double total = 0.0;
    portfolio.forEach((company, shares) => total += company.price * shares);
    return total;
  }

  // --- Saga / Mail Logic ---

  bool invest(Offer offer) {
    if (cash >= offer.investmentCost) {
      cash -= offer.investmentCost;
      activeInvestments.add(offer);
      calculateNetWorth();
      return true;
    }
    return false;
  }

  // --- RESTORED STOCK METHODS ---

  void buyStock(Company company, int shares) {
    double cost = company.price * shares;
    if (cash >= cost) {
      cash -= cost;
      // Update portfolio map: add shares to existing or start at 0
      portfolio[company] = (portfolio[company] ?? 0) + shares;
      calculateNetWorth();
    }
  }

  void sellStock(Company company, int shares) {
    int currentShares = portfolio[company] ?? 0;
    if (currentShares >= shares) {
      cash += company.price * shares;
      portfolio[company] = currentShares - shares;
      
      // Clean up the map if we no longer own any shares
      if (portfolio[company] == 0) {
        portfolio.remove(company);
      }
      calculateNetWorth();
    }
  }
}