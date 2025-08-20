import 'package:hive/hive.dart';

part 'transaction.manual.dart'; // <-- tiny shim to keep file clean

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String category;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  bool isIncome;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.isIncome,
  });
}
