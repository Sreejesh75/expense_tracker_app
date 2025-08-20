import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/transaction_providers.dart';
import '../widgets/chart_widget.dart';

class StatsScreen extends StatelessWidget {
  static const route = '/stats';
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<TransactionProvider>();
    final byCat = tp.expensesByCategory();

    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _summaryCard('Income', tp.totalIncome),
                _summaryCard('Expense', tp.totalExpense),
                _summaryCard('Balance', tp.totalIncome - tp.totalExpense),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Expenses by Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            CategoryBarChart(data: byCat),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String label, double value) {
    return SizedBox(
      width: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              const SizedBox(height: 6),
              Text(
                '₹${value.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
