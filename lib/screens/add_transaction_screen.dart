import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/categories.dart';
import '../cubit/transactions_cubit.dart';
import '../models/transaction_model.dart';

/// Lets the user enter a new expense. On save it's added to the cubit, which
/// stores it locally and updates the dashboard.
class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _category = kCategories.first;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text.replaceAll(',', '.')),
      date: DateTime.now(),
      category: _category,
    );

    context.read<TransactionsCubit>().add(transaction);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Add expense')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'e.g. Groceries',
                    prefixIcon: Icon(Icons.edit_outlined),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter a title'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixText: '\$ ',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an amount';
                    }
                    final parsed = double.tryParse(value.replaceAll(',', '.'));
                    if (parsed == null || parsed <= 0) {
                      return 'Enter a valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: kCategories
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Row(
                            children: [
                              Icon(iconForCategory(c),
                                  size: 20, color: scheme.secondary),
                              const SizedBox(width: 10),
                              Text(c),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _category = value ?? _category),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.check),
                    label: const Text(
                      'Save expense',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
