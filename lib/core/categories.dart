import 'package:flutter/material.dart';

// Expense categories
const List<String> kCategories = [
  'Food & Drinks',
  'Shopping',
  'Transportation',
  'Entertainment',
  'Bills',
  'Other',
];

// Category icons
IconData iconForCategory(String category) {
  switch (category) {
    case 'Food & Drinks':
      return Icons.restaurant;
    case 'Shopping':
      return Icons.shopping_bag;
    case 'Transportation':
      return Icons.directions_bus;
    case 'Entertainment':
      return Icons.movie;
    case 'Bills':
      return Icons.receipt_long;
    default:
      return Icons.attach_money;
  }
}
