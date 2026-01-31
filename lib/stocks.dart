import 'package:flutter/material.dart';
import 'widgets/top_section.dart'; // <-- reusable top section

enum RiskLevel { low, medium, high }

class Stock {
  final String name;
  final RiskLevel risk;
  int owned;
  double price;
  bool goingUp;

  Stock({
    required this.name,
    required this.risk,
    this.owned = 0,
    this.price = 0,
    this.goingUp = true,
  });
}

class StocksPage extends StatefulWidget {
  const StocksPage({super.key});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  late List<Stock> stocks;

  @override
  void initState() {
    super.initState();

    stocks = List.generate(21, (index) {
      return Stock(
        name: 'Stock ${index + 1}',
        risk: RiskLevel.values[index % 3], // hidden risk
        goingUp: index % 2 == 0, // alternate up/down for now
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Stocks'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          const TopSection(), // <-- Profile + Net Worth + Cash

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- TOP ROW ----------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            stock.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Row(
                            children: [
                              Text(
                                '\$${stock.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: stock.goingUp
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                stock.goingUp
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                size: 16,
                                color: stock.goingUp
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // ---------- DESCRIPTION ----------
                      const Text(
                        'description pending...',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ---------- BUY / SELL ----------
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: stock.owned > 0
                                ? () {
                                    setState(() {
                                      stock.owned--;
                                    });
                                  }
                                : null,
                          ),
                          Text(
                            stock.owned.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                stock.owned++;
                              });
                            },
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
}
