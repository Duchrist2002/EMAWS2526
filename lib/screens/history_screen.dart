import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/transactions_cubit.dart';
import '../widgets/dashboard/transaction_item.dart';

/// Shows the full list of expenses.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
      ),
      body: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.transactions.isEmpty) {
            return const Center(
              child: Text('No expenses recorded yet.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.transactions.length,
            itemBuilder: (context, index) {
              return TransactionItem(transaction: state.transactions[index]);
            },
          );
        },
      ),
    );
  }
}
