import 'package:flutter/material.dart';

class BudgetSummaryCard extends StatelessWidget {
  final String title;
  final String amountText;
  final String subtitle;
  final bool isLarge;

  const BudgetSummaryCard({
    Key? key,
    required this.title,
    required this.amountText,
    required this.subtitle,
    this.isLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Colors taken from the dashboard design
    const Color cardBackground = Colors.white;
    const Color darkOlive = Color(0xFF345135);

    return Container(
      width: isLarge ? double.infinity : null,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: darkOlive.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: darkOlive,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            amountText,
            style: const TextStyle(
              color: darkOlive,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: darkOlive.withOpacity(0.7),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
