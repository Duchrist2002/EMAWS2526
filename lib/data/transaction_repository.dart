import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction_model.dart';

/// Stores the transaction list locally using shared_preferences (as JSON).
///
/// This is the only place that talks to storage, which keeps the Cubit and
/// the UI free of persistence details.
class TransactionRepository {
  static const _storageKey = 'transactions';

  Future<List<TransactionModel>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    // First launch: seed a couple of example entries so the app isn't empty.
    if (raw == null) {
      await _write(prefs, _seed());
      return _seed();
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveAll(List<TransactionModel> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    await _write(prefs, transactions);
  }

  Future<void> _write(
      SharedPreferences prefs, List<TransactionModel> transactions) {
    final raw = jsonEncode(transactions.map((t) => t.toJson()).toList());
    return prefs.setString(_storageKey, raw);
  }

  List<TransactionModel> _seed() => [
        TransactionModel(
          id: 'seed-1',
          title: 'Starbucks',
          amount: 5.50,
          date: DateTime.now().subtract(const Duration(hours: 2)),
          category: 'Food & Drinks',
        ),
        TransactionModel(
          id: 'seed-2',
          title: 'Bus ticket',
          amount: 2.50,
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Transportation',
        ),
      ];
}
