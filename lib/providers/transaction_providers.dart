import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TransactionProvider with ChangeNotifier {
  late final Box<TransactionModel> _box;

  TransactionProvider() {
    _box = HiveService.box();
  }

  List<TransactionModel> get transactions {
    final list = _box.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date)); // newest first
    return list;
  }

  Future<void> add(TransactionModel tx) async {
    await _box.add(tx);
    notifyListeners();
  }

  Future<void> removeAt(int indexInListOrder) async {
    // list order is sorted; map back to real key
    final sorted = transactions;
    final tx = sorted[indexInListOrder];
    // find the first matching entry in box
    final key = _box.keys.firstWhere(
      (k) => _box.get(k) == tx,
      orElse: () => null,
    );
    if (key != null) {
      await _box.delete(key);
      notifyListeners();
    }
  }

  double get totalIncome =>
      transactions.where((t) => t.isIncome).fold(0.0, (s, t) => s + t.amount);

  double get totalExpense =>
      transactions.where((t) => !t.isIncome).fold(0.0, (s, t) => s + t.amount);

  Map<String, double> expensesByCategory() {
    final map = <String, double>{};
    for (final t in transactions.where((t) => !t.isIncome)) {
      map[t.category] = (map[t.category] ?? 0) + t.amount;
    }
    return map;
  }
}
