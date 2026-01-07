class Expense {
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final String? note;

  Expense({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    this.note,
  });
}
