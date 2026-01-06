import 'package:flutter/material.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final IconData icon;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.icon,
  });
}

// Mock data for the dashboard (later replaced by Firestore stream)
final List<TransactionModel> mockTransactions = [
  TransactionModel(
    id: 't1',
    title: 'Starbucks',
    amount: 5.50,
    date: DateTime.now().subtract(const Duration(minutes: 30)),
    category: 'Food & Drinks',
    icon: Icons.local_cafe,
  ),
  TransactionModel(
    id: 't2',
    title: 'Target',
    amount: 45.20,
    date: DateTime.now().subtract(const Duration(hours: 1)),
    category: 'Shopping',
    icon: Icons.shopping_bag,
  ),
  TransactionModel(
    id: 't3',
    title: 'Metro Transit',
    amount: 2.50,
    date: DateTime.now().subtract(const Duration(days: 1, hours: 16)),
    category: 'Transportation',
    icon: Icons.directions_bus,
  ),
  TransactionModel(
    id: 't4',
    title: 'Pizza Palace',
    amount: 18.75,
    date: DateTime.now().subtract(const Duration(days: 1, hours: 14)),
    category: 'Food & Drinks',
    icon: Icons.local_pizza,
  ),
  TransactionModel(
    id: 't5',
    title: 'AMC Cinema',
    amount: 12.00,
    date: DateTime.now().subtract(const Duration(days: 2)),
    category: 'Entertainment',
    icon: Icons.movie,
  ),
];
