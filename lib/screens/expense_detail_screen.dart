import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../core/categories.dart';
import '../cubit/transactions_cubit.dart';
import '../models/transaction_model.dart';

/// Shows the full details of a single expense and lets the user delete it.
class ExpenseDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const ExpenseDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dateStr = DateFormat.yMMMMd().add_Hm().format(transaction.date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
        actions: [
          IconButton(
            tooltip: 'Delete expense',
            icon: Icon(Icons.delete_outline, color: scheme.error),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon + Amount hero
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: scheme.secondary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        iconForCategory(transaction.category),
                        size: 48,
                        color: scheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '\$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: scheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      transaction.category,
                      style: TextStyle(
                        fontSize: 16,
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Detail rows
              _DetailTile(
                icon: Icons.label_outline,
                label: 'Title',
                value: transaction.title,
                scheme: scheme,
              ),
              _DetailTile(
                icon: Icons.calendar_today_outlined,
                label: 'Date',
                value: dateStr,
                scheme: scheme,
              ),
              _DetailTile(
                icon: Icons.category_outlined,
                label: 'Category',
                value: transaction.category,
                scheme: scheme,
              ),
              if (transaction.note != null && transaction.note!.isNotEmpty)
                _DetailTile(
                  icon: Icons.notes_outlined,
                  label: 'Note',
                  value: transaction.note!,
                  scheme: scheme,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete expense?'),
        content: Text(
          'Are you sure you want to delete "${transaction.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TransactionsCubit>().remove(transaction.id);
              Navigator.of(ctx).pop(); // close dialog
              Navigator.of(context).pop(); // go back to list
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ColorScheme scheme;

  const _DetailTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: scheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
