import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel tx;
  final VoidCallback? onDelete;

  const TransactionTile({super.key, required this.tx, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isIncome = tx.isIncome;
    final sign = isIncome ? '+' : '-';
    final amountText = '$sign₹${tx.amount.toStringAsFixed(2)}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            tx.category.isNotEmpty ? tx.category[0].toUpperCase() : '?',
          ),
        ),
        title: Text(tx.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${tx.category} • ${DateFormat.yMMMd().format(tx.date)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              amountText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
