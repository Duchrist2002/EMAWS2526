import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme.dart';
import '../cubit/transactions_cubit.dart';
import '../services/auth_service.dart';
import '../widgets/dashboard/budget_summary_card.dart';
import '../widgets/dashboard/transaction_item.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerColor = isDark ? const Color(0xFF3B4A22) : AppTheme.oliveGreen;

    final user = AuthService.instance.currentUser;
    final firstName = (user?.displayName?.trim().isNotEmpty ?? false)
        ? user!.displayName!.trim().split(' ').first
        : (user?.email?.split('@').first ?? 'there');

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            final spent = state.total;
            final budget = state.monthlyBudget;
            final saved = budget - spent;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- Header ----------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 16, 12, 20),
                    decoration: BoxDecoration(
                      color: headerColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Hi, $firstName 👋',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Take ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              TextSpan(
                                text: 'control',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                    fontSize: 18),
                              ),
                              TextSpan(
                                text: ' of your budget!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---------- Summary ----------
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            BudgetSummaryCard(
                              isLarge: true,
                              title: 'Spent this month',
                              amountText: '\$${spent.toStringAsFixed(2)}',
                              subtitle:
                                  'of your \$${budget.toStringAsFixed(0)} budget',
                            ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: FloatingActionButton.small(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                onPressed: () => _showEditBudgetDialog(context, budget),
                                child: const Icon(Icons.edit, color: Colors.white),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ---------- This month ----------
                        _sectionTitle(context, 'This month'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: BudgetSummaryCard(
                                title: 'Spent',
                                amountText: '\$${spent.toStringAsFixed(0)}',
                                subtitle: 'so far',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: BudgetSummaryCard(
                                title: 'Saved',
                                amountText: '\$${saved.toStringAsFixed(0)}',
                                subtitle: 'this month',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                                child: BudgetSummaryCard(
                                  title: 'Goal',
                                  amountText: '\$${budget.toStringAsFixed(0)}',
                                  subtitle: 'target',
                                ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ---------- Recent transactions ----------
                        _sectionTitle(context, 'Recent transactions'),
                        const SizedBox(height: 8),
                        _TransactionList(state: state),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) => Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );

  void _showEditBudgetDialog(BuildContext context, double currentBudget) {
    final controller =
        TextEditingController(text: currentBudget.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Monthly Budget'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Budget (\$)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newBudget = double.tryParse(controller.text);
              if (newBudget != null && newBudget >= 0) {
                context.read<TransactionsCubit>().setBudget(newBudget);
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

/// Shows a spinner while loading, an empty hint, or the transaction list.
class _TransactionList extends StatelessWidget {
  final TransactionsState state;
  const _TransactionList({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.loading) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.transactions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'No expenses yet.\nTap “Add expense” to get started.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
            ),
          ),
        ),
      );
    }
    return Column(
      children: state.transactions
          .map((t) => TransactionItem(transaction: t))
          .toList(),
    );
  }
}
