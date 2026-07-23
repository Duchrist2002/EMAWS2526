import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:helloworld/cubit/transactions_cubit.dart';
import 'package:helloworld/data/transaction_repository.dart';
import 'package:helloworld/models/transaction_model.dart';

void main() {
  // shared_preferences needs the test binding + mocked values.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TransactionsCubit', () {
    late TransactionsCubit cubit;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      cubit = TransactionsCubit(TransactionRepository());
      await cubit.load();
    });

    test('seeds example transactions on first launch', () {
      expect(cubit.state.loading, isFalse);
      expect(cubit.state.transactions, isNotEmpty);
    });

    test('adding a transaction grows the list and the total', () async {
      final totalBefore = cubit.state.total;
      final countBefore = cubit.state.transactions.length;

      await cubit.add(
        TransactionModel(
          id: 'test-1',
          title: 'Book',
          amount: 12.50,
          date: DateTime.now(),
          category: 'Shopping',
        ),
      );

      expect(cubit.state.transactions.length, countBefore + 1);
      expect(cubit.state.total, closeTo(totalBefore + 12.50, 0.001));
    });

    test('removing a transaction lowers the total', () async {
      await cubit.add(
        TransactionModel(
          id: 'to-remove',
          title: 'Temp',
          amount: 9.99,
          date: DateTime.now(),
          category: 'Other',
        ),
      );
      final totalWithItem = cubit.state.total;

      await cubit.remove('to-remove');

      expect(cubit.state.total, closeTo(totalWithItem - 9.99, 0.001));
      expect(
        cubit.state.transactions.any((t) => t.id == 'to-remove'),
        isFalse,
      );
    });

    test('persists across cubit instances (saved to storage)', () async {
      await cubit.add(
        TransactionModel(
          id: 'persist-1',
          title: 'Gym',
          amount: 30.0,
          date: DateTime.now(),
          category: 'Bills',
        ),
      );

      // A fresh cubit reading the same storage should see the new entry.
      final reopened = TransactionsCubit(TransactionRepository());
      await reopened.load();

      expect(
        reopened.state.transactions.any((t) => t.id == 'persist-1'),
        isTrue,
      );
    });
  });
}
