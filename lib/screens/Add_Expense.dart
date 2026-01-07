import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String category = "Food";

  void _submit() {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text);

    if (title.isEmpty || amount == null || amount <= 0) {
      return;
    }

    final newExpense = Expense(
      title: title,
      amount: amount,
      category: category,
      note: noteController.text.trim(),
      date: DateTime.now(),
    );

    Navigator.pop(context, newExpense);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1A589),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1A589),
        elevation: 0,
        title: const Text(
          "Add Expense",
          style: TextStyle(color: Color(0xFF345135)),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF345135)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // TASK NAME
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Task name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // AMOUNT
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // CATEGORY
              DropdownButtonFormField<String>(
                value: category,
                items: const [
                  DropdownMenuItem(value: "Food", child: Text("Food")),
                  DropdownMenuItem(
                      value: "Transport", child: Text("Transport")),
                  DropdownMenuItem(value: "Bills", child: Text("Bills")),
                  DropdownMenuItem(value: "Shopping", child: Text("Shopping")),
                  DropdownMenuItem(value: "Health", child: Text("Health")),
                  DropdownMenuItem(value: "Leisure", child: Text("Leisure")),
                  DropdownMenuItem(value: "Other", child: Text("Other")),
                ],
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Category",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // NOTE
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Note (optional)",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const Spacer(),

              // ADD BUTTON (en bas)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1f9829),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    "Add Expense",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
