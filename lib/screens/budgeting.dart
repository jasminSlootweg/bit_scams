import 'package:flutter/material.dart';
import 'dart:math';
import '../models/user.dart';

class BudgetPage extends StatelessWidget {
  final User user;
  const BudgetPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const Color primaryNavy = Color.fromRGBO(2, 30, 67, 1);

    // Prepare data for the pie chart
    final Map<String, double> expenses = {
      'Rent': user.rent,
      'Groceries': user.groceries,
      'Transport': user.transportation,
      'Insurance': user.carInsurance,
      'Other': user.otherExpenses,
    };

    // Filter out zero expenses to avoid cluttering the chart
    final activeExpenses = Map.fromEntries(expenses.entries.where((e) => e.value > 0));
    
    final List<Color> chartColors = [
      const Color.fromRGBO(252, 211, 25, 1),  // Yellow
      const Color.fromRGBO(74, 177, 232, 1), // Blue
      const Color.fromRGBO(12, 194, 21, 1),  // Green
      const Color.fromRGBO(204, 70, 76, 1),  // Red
      const Color.fromRGBO(155, 89, 182, 1), // Purple (Extra)
    ];

    return Scaffold(
      backgroundColor: primaryNavy,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/budget_card.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- PIE CHART SECTION ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 280,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [
                    const Text(
                      "MONTHLY EXPENSE BREAKDOWN",
                      style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: PieChartPainter(activeExpenses, chartColors),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- SUMMARY LIST ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("EXPENSE DETAILS", 
                    style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 12),
                  ...activeExpenses.entries.toList().asMap().entries.map((entry) {
                    int idx = entry.key;
                    var data = entry.value;
                    return _buildBudgetTile(
                      data.key, 
                      data.value, 
                      chartColors[idx % chartColors.length]
                    );
                  }),
                  const Divider(color: Colors.white10, height: 32),
                  _buildBudgetTile("Total Monthly Costs", user.monthlyCosts, Colors.white, isTotal: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetTile(String label, double amount, Color color, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: isTotal ? Colors.white : Colors.white70, fontSize: 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          const Spacer(),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// --- PIE CHART PAINTER ---
class PieChartPainter extends CustomPainter {
  final Map<String, double> data;
  final List<Color> colors;

  PieChartPainter(this.data, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final double total = data.values.fold(0, (sum, item) => sum + item);
    if (total <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    double startAngle = -pi / 2; // Start at the top

    int index = 0;
    data.forEach((key, value) {
      final sweepAngle = (value / total) * 2 * pi;
      final paint = Paint()
        ..color = colors[index % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      
      // Draw a subtle white border between slices
      final borderPaint = Paint()
        ..color = const Color.fromRGBO(2, 30, 67, 1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawArc(rect, startAngle, sweepAngle, true, borderPaint);

      startAngle += sweepAngle;
      index++;
    });

    // Optional: Draw a "Donut" hole to make it modern
    final holePaint = Paint()..color = const Color.fromRGBO(255, 255, 255, 0.05);
    canvas.drawCircle(center, radius * 0.4, holePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}