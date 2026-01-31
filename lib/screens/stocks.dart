import 'package:flutter/material.dart';
import '../widgets/top_section.dart';
import '../models/company.dart';
import '../models/user.dart';

class StocksPage extends StatefulWidget {
  final User user;

  const StocksPage({super.key, required this.user});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  List<Company> companyList = [];
  final Color primaryNavy = const Color.fromRGBO(2, 30, 67, 1);

  @override
  void initState() {
    super.initState();
    // Use the global list of companies defined in company.dart
    companyList = List.from(companies);
    
    // Ensure companies have a starting price if they don't already
    for (var company in companyList) {
      if (company.price == 0) {
        company.price = 50 + (companyList.indexOf(company) * 5.0);
      }
    }
  }

  /// Helper to handle the logic of buying a stock with a debt warning
  void _handleBuy(Company company) {
    double remainingCash = widget.user.cash - company.price;

    // Safety check: Is the user spending money they need for bills?
    if (remainingCash < widget.user.monthlyCosts) {
      _showDebtWarning(company);
    } else {
      setState(() {
        widget.user.buyStock(company, 1);
      });
    }
  }

  /// Alert Dialog for Financial Risk
  void _showDebtWarning(Company company) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: primaryNavy,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), 
          side: const BorderSide(color: Colors.white10),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
            SizedBox(width: 10),
            Text('Financial Risk', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          'Buying this stock will leave you with \$${(widget.user.cash - company.price).toStringAsFixed(2)}. '
          'Your monthly expenses are \$${widget.user.monthlyCosts.toStringAsFixed(2)}.\n\n'
          'You risk going into debt next month!',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              setState(() => widget.user.buyStock(company, 1));
              Navigator.pop(context);
            },
            child: const Text('Buy Anyway', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryNavy,
      appBar: AppBar(
        title: const Text('MARKET', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // The calendar button has been removed to prevent out-of-sync month processing
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          TopSection(user: widget.user),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: companyList.length,
              itemBuilder: (context, index) {
                final company = companyList[index];
                final int sharesOwned = widget.user.portfolio[company] ?? 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStockHeader(company),
                      const SizedBox(height: 12),
                      Text(
                        company.description,
                        style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7)),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'OWNED: $sharesOwned',
                            style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Row(
                            children: [
                              _actionButton(
                                label: 'SELL',
                                color: Colors.redAccent,
                                onPressed: sharesOwned > 0 
                                  ? () => setState(() => widget.user.sellStock(company, 1)) 
                                  : null,
                              ),
                              const SizedBox(width: 12),
                              _actionButton(
                                label: 'BUY',
                                color: Colors.greenAccent,
                                onPressed: widget.user.cash >= company.price 
                                  ? () => _handleBuy(company) 
                                  : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockHeader(Company company) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(company.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(company.sector.toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.green, letterSpacing: 1.2)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${company.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: company.goingUp ? Colors.greenAccent : Colors.redAccent,
              ),
            ),
            Icon(
              company.goingUp ? Icons.trending_up : Icons.trending_down,
              size: 18,
              color: company.goingUp ? Colors.greenAccent : Colors.redAccent,
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionButton({required String label, required Color color, VoidCallback? onPressed}) {
    bool isActive = onPressed != null;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? color.withOpacity(0.3) : Colors.white10,
        foregroundColor: isActive ? color : Colors.white24,
        side: BorderSide(color: isActive ? color.withOpacity(0.8) : Colors.white10, width: 1.5),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        label, 
        style: TextStyle(
          fontWeight: FontWeight.w900, 
          letterSpacing: 1.1,
          color: isActive ? color : Colors.white24,
        ),
      ),
    );
  }
}