import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/transaction_repository.dart';
import '../models/transaction_model.dart';

/// State held by [TransactionsCubit]: the current list plus a loading flag.
class TransactionsState {
  final List<TransactionModel> transactions;
  final bool loading;
  final double monthlyBudget;

  const TransactionsState({
    this.transactions = const [],
    this.loading = true,
    this.monthlyBudget = 800.0,
  });

  /// Total amount spent across all transactions.
  double get total => transactions.fold(0.0, (sum, t) => sum + t.amount);

  TransactionsState copyWith({
    List<TransactionModel>? transactions,
    bool? loading,
    double? monthlyBudget,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      loading: loading ?? this.loading,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
    );
  }
}

/// Manages the transaction list and keeps it in sync with local storage.
///
/// Business logic lives here, separate from the widgets — the UI only reads
/// the state and calls [add] / [remove].
class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionRepository _repository;

  TransactionsCubit(this._repository) : super(const TransactionsState());

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    try {
      final items = await _repository.loadAll();
      final budget = await _repository.loadBudget();
      _emitSorted(items, budget: budget);
    } catch (e) {
      // Never leave the UI stuck on a spinner if storage is unavailable.
      debugPrint('TransactionsCubit.load failed: $e');
      emit(const TransactionsState(transactions: [], loading: false));
    }
  }

  Future<void> add(TransactionModel transaction) async {
    final updated = [transaction, ...state.transactions];
    _emitSorted(updated);
    await _repository.saveAll(updated);
  }

  Future<void> remove(String id) async {
    final updated = state.transactions.where((t) => t.id != id).toList();
    _emitSorted(updated);
    await _repository.saveAll(updated);
  }

  Future<void> setBudget(double newBudget) async {
    emit(state.copyWith(monthlyBudget: newBudget));
    await _repository.saveBudget(newBudget);
  }

  /// Emits the list newest-first so the dashboard shows recent items on top.
  void _emitSorted(List<TransactionModel> items, {double? budget}) {
    final sorted = [...items]..sort((a, b) => b.date.compareTo(a.date));
    emit(TransactionsState(
      transactions: sorted,
      loading: false,
      monthlyBudget: budget ?? state.monthlyBudget,
    ));
  }
}
