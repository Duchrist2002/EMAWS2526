import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../widgets/dashboard/budget_summary_card.dart';
import '../widgets/dashboard/transaction_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const Color peachBackground = Color(0xFFFFE2C7);
  static const Color darkOlive = Color(0xFF345135);

  double _calculateTotalSpent(List<TransactionModel> transactions) {
    return transactions.fold(
      0.0,
      (previousValue, element) => previousValue + element.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    const double totalMonthlyBudget = 2000.0;

    final double totalSpent = _calculateTotalSpent(mockTransactions);
    final double remainingBudget = totalMonthlyBudget - totalSpent;

    final currencyFormatter = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: peachBackground,
      appBar: AppBar(
        backgroundColor: peachBackground,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Hello, Student!',
          style: TextStyle(
            color: darkOlive,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: darkOlive.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_none,
              color: darkOlive,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BudgetSummaryCard(
                      title: 'Remaining Budget',
                      amountText:
                          currencyFormatter.format(remainingBudget.toInt()),
                      subtitle: 'for this month',
                      isLarge: true,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: BudgetSummaryCard(
                            title: 'Total Monthly Budget',
                            amountText: currencyFormatter
                                .format(totalMonthlyBudget.toInt()),
                            subtitle: '',
                            isLarge: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BudgetSummaryCard(
                            title: 'Total Spent',
                            amountText:
                                currencyFormatter.format(totalSpent.toInt()),
                            subtitle: '',
                            isLarge: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(
                        color: darkOlive,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mockTransactions.length,
                      itemBuilder: (ctx, index) {
                        return TransactionItem(
                          transaction: mockTransactions[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkOlive,
        onPressed: () {
          Navigator.of(context).pushNamed('/add_expense');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _BottomNavItem(
                icon: Icons.home,
                label: 'Home',
                isActive: true,
              ),
              _BottomNavItem(
                icon: Icons.history,
                label: 'History',
              ),
              SizedBox(width: 40),
              _BottomNavItem(
                icon: Icons.bar_chart,
                label: 'Statistics',
              ),
              _BottomNavItem(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color darkOlive = Color(0xFF345135);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 22,
          color: isActive ? darkOlive : darkOlive.withOpacity(0.5),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? darkOlive : darkOlive.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
