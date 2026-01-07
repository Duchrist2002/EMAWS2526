import 'package:flutter/material.dart';
import '../models/expense.dart';

class HistoryScreen extends StatelessWidget {
  final List<Expense> expenses;

  const HistoryScreen({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: expenses.isEmpty
          ? const Center(child: Text("No expenses yet"))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final e = expenses[index];
                return ListTile(
                  title: Text(e.title),
                  subtitle: Text(e.category),
                  trailing: Text("${e.amount.toStringAsFixed(2)} €"),
                );
              },
            ),
    );
  }
}
