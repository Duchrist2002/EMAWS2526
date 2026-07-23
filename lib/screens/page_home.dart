import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/theme_controller.dart';
import '../models/transaction_model.dart';
import '../services/auth_service.dart';
import '../widgets/dashboard/budget_summary_card.dart';
import '../widgets/dashboard/transaction_item.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerColor =
        isDark ? const Color(0xFF3B4A22) : AppTheme.oliveGreen;

    final user = AuthService.instance.currentUser;
    final firstName = (user?.displayName?.trim().isNotEmpty ?? false)
        ? user!.displayName!.trim().split(' ').first
        : (user?.email?.split('@').first ?? 'there');

    // Simple figures derived from the mock data (later: from Firestore).
    final spent = mockTransactions.fold<double>(0, (s, t) => s + t.amount);
    const saved = 220.0;
    const goal = 800.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        // Dark-mode switch
                        Icon(
                          isDark ? Icons.dark_mode : Icons.light_mode,
                          color: Colors.white,
                          size: 20,
                        ),
                        Switch(
                          value: isDark,
                          activeThumbColor: Colors.white,
                          activeTrackColor: Colors.white24,
                          onChanged: (v) =>
                              ThemeController.instance.setDark(v),
                        ),
                        IconButton(
                          tooltip: 'Log out',
                          icon: const Icon(Icons.logout, color: Colors.white),
                          onPressed: () async {
                            await AuthService.instance.signOut();
                            if (context.mounted) {
                              Navigator.of(context)
                                  .popUntil((r) => r.isFirst);
                            }
                          },
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
                    BudgetSummaryCard(
                      isLarge: true,
                      title: 'Spent this month',
                      amountText: '\$${spent.toStringAsFixed(2)}',
                      subtitle: 'of your \$${goal.toStringAsFixed(0)} budget',
                    ),

                    const SizedBox(height: 24),

                    // ---------- Quick tools ----------
                    _sectionTitle(context, 'Quick tools'),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ToolButton(
                            icon: Icons.account_balance_wallet,
                            label: 'Wallet'),
                        _ToolButton(icon: Icons.savings, label: 'Savings'),
                        _ToolButton(
                            icon: Icons.show_chart, label: 'Analysis'),
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
                            amountText: '\$${goal.toStringAsFixed(0)}',
                            subtitle: 'target',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ---------- Recent transactions ----------
                    _sectionTitle(context, 'Recent transactions'),
                    const SizedBox(height: 8),
                    ...mockTransactions.map(
                      (t) => TransactionItem(transaction: t),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
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
}

/// Rounded shortcut tile used in the "Quick tools" row.
class _ToolButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ToolButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Material(
          color: scheme.secondary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label — coming soon')),
            ),
            child: Container(
              width: 70,
              height: 70,
              alignment: Alignment.center,
              child: Icon(icon, size: 34, color: scheme.secondary),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: scheme.onSurface)),
      ],
    );
  }
}
