import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import 'Add_Expense.dart';
import 'expense_detail_screen.dart';
import 'history.dart';

class DashboardScreen extends StatefulWidget {
  final String username;
  const DashboardScreen({Key? key, this.username = "Student"})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Expense> expenses = [];
  double monthlyBudget = 20;

  void _showEditBudgetDialog(BuildContext context) {
    final controller =
        TextEditingController(text: monthlyBudget.toStringAsFixed(0));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Monthly Budget"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Budget (€)",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1f9829),
            ),
            onPressed: () {
              setState(() {
                monthlyBudget =
                    double.tryParse(controller.text) ?? monthlyBudget;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  List<Expense> get recentExpenses {
    final now = DateTime.now();
    return expenses.where((e) {
      return e.date.isAfter(now.subtract(const Duration(days: 10)));
    }).toList();
  }

  double get totalSpent => expenses.fold(0, (sum, e) => sum + e.amount);

  final Color peachBackground = const Color(0xffde7d46);
  final Color darkOlive = const Color(0xFF345135);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: "€", decimalDigits: 2);

    return Scaffold(
      backgroundColor: peachBackground,

      // ➕ BOUTON +
      floatingActionButton: Transform.translate(
        offset: const Offset(
            0, -26), // 🔼 monte le bouton (essaie -12, -16 si besoin)
        child: FloatingActionButton(
          backgroundColor: darkOlive,
          onPressed: () async {
            final result = await Navigator.pushNamed(context, '/add_expense');

            if (result != null && result is Expense) {
              _addExpense(result);
            }
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),

//  le FAB reste docked
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: BottomAppBar(
        notchMargin: 10, // notch un peu plus large = FAB plus respirant
        color: Colors.white,
        child: SizedBox(
          height: 70, // AVANT: 60 → maintenant 70
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                icon: Icons.home,
                label: 'Home',
                isActive: true,
                onTap: () {
                  // Si on est déjà sur le Dashboard, rien à faire
                },
              ),
              _BottomNavItem(
                icon: Icons.history,
                label: 'History',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HistoryScreen(expenses: expenses),
                    ),
                  );
                },
              ),
              SizedBox(width: 48), // espace pour le FAB
              _BottomNavItem(
                icon: Icons.bar_chart,
                label: 'Statistics',
                onTap: () {
                  // Pour l'instant, rien ou naviguer vers une page stats
                },
              ),
              _BottomNavItem(
                icon: Icons.settings,
                label: 'Settings',
                onTap: () {
                  // Pour l'instant, rien ou naviguer vers Settings
                },
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👋 HELLO USER
              Text(
                "Hello, ${widget.username}!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkOlive,
                ),
              ),
              const SizedBox(height: 20),

              // 💰 REMAINING BUDGET
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // 🟦 CARTE BLANCHE
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: _SummaryCard(
                          title: "Remaining Budget",
                          amount: formatter.format(monthlyBudget - totalSpent),
                          subtitle: "This month",
                          large: true,
                        ),
                      ),

                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton.small(
                          backgroundColor: const Color(0xff1f9829),
                          onPressed: () => _showEditBudgetDialog(context),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: "Monthly Budget",
                      amount: formatter.format(monthlyBudget),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      title: "Total Spent",
                      amount: formatter.format(totalSpent),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                "Last 10 days",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF345135),
                ),
              ),

              const SizedBox(height: 8),

              // 💸 LISTE DES DÉPENSES RÉCENTES
              Expanded(
                child: recentExpenses.isEmpty
                    ? const Center(child: Text("No recent expenses"))
                    : ListView.builder(
                        itemCount: recentExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = recentExpenses[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ExpenseDetailScreen(expense: expense),
                                ),
                              );
                            },
                            child: _ExpenseTile(expense: expense),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== SUMMARY CARD =====================
class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String? subtitle;
  final bool large;

  const _SummaryCard({
    required this.title,
    required this.amount,
    this.subtitle,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            amount,
            style: TextStyle(
              fontSize: large ? 28 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF345135),
            ),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(subtitle!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
        ],
      ),
    );
  }
}

// ===================== EXPENSE TILE =====================
class _ExpenseTile extends StatelessWidget {
  final Expense expense;

  const _ExpenseTile({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(expense.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            "${expense.category} • ${DateFormat('dd/MM/yyyy').format(expense.date)}"),
        trailing: Text("${expense.amount.toStringAsFixed(2)} €",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF345135),
            )),
      ),
    );
  }
}

// ===================== BOTTOM NAV ITEM =====================
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color darkOlive = Color(0xFF345135);

    return GestureDetector(
      onTap: onTap,
      child: Column(
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
      ),
    );
  }
}
