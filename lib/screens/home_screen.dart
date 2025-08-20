import 'package:flutter/material.dart';
import 'package:expense_tracker/providers/transaction_providers.dart';
import 'package:expense_tracker/widgets/transaction_tile.dart';
import 'add_transaction_screen.dart';
import 'stats_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<TransactionProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            tooltip: 'Stats',
            icon: const Icon(Icons.insights_outlined),
            onPressed: () => Navigator.pushNamed(context, StatsScreen.route),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _summaryChip(
                    'Income',
                    '₹${tp.totalIncome.toStringAsFixed(0)}',
                  ),
                  const SizedBox(width: 12),
                  _summaryChip(
                    'Expense',
                    '₹${tp.totalExpense.toStringAsFixed(0)}',
                  ),
                  const Spacer(),
                  _summaryChip(
                    'Balance',
                    '₹${(tp.totalIncome - tp.totalExpense).toStringAsFixed(0)}',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: tp.transactions.isEmpty
                ? const Center(child: Text('No transactions yet'))
                : ListView.builder(
                    itemCount: tp.transactions.length,
                    itemBuilder: (context, index) {
                      final tx = tp.transactions[index];
                      return TransactionTile(
                        tx: tx,
                        onDelete: () => tp.removeAt(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushNamed(context, AddTransactionScreen.route),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }

  Widget _summaryChip(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
