class MonthSummary {
  final double incomeEarned;
  final double expensesPaid;
  final double stockChange;
  final double netChange; // Add this line

  MonthSummary({
    required this.incomeEarned,
    required this.expensesPaid,
    required this.stockChange,
    required this.netChange, // Add this line
  });
}