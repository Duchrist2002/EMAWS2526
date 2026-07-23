import 'package:flutter/material.dart';

/// The expense categories a user can choose from.
const List<String> kCategories = [
  'Food & Drinks',
  'Shopping',
  'Transportation',
  'Entertainment',
  'Bills',
  'Other',
];

/// Maps a category to the icon shown next to it.
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
