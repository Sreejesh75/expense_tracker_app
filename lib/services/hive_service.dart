import 'package:expense_tracker/models/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String transactionsBox = 'transactions';

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TransactionModelAdapter());
    }
    await Hive.openBox<TransactionModel>(transactionsBox);
  }

  static Box<TransactionModel> box() =>
      Hive.box<TransactionModel>(transactionsBox);
}
