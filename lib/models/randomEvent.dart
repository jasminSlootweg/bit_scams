import 'user.dart';

/// Represents a sudden life event that impacts the user's finances.
class RandomEvent {
  final String title;
  final String description;
  
  /// The immediate financial impact on the user's cash.
  /// Positive = Income/Bonus, Negative = Expense/Loss.
  final double cashImpact;

  /// Optional: If you want certain events to change monthly income permanently.
  final double monthlyIncomeChange;

  RandomEvent({
    required this.title,
    required this.description,
    required this.cashImpact,
    this.monthlyIncomeChange = 0.0,
  });

  /// Logic stub to apply the event to the user
  void execute(User user) {
    // 1. Apply the one-time cash impact
    // 2. Apply any permanent income/expense changes
    // 3. Recalculate user net worth
  }
}