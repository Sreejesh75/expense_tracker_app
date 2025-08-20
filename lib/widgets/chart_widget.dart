import 'package:flutter/material.dart';

class CategoryBarChart extends StatelessWidget {
  final Map<String, double> data; // category -> amount
  const CategoryBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No expense data'));
    }
    final maxVal = data.values.reduce((a, b) => a > b ? a : b);
    return Column(
      children: data.entries.map((e) {
        final fraction = (e.value / (maxVal == 0 ? 1 : maxVal)).clamp(0.0, 1.0);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              SizedBox(width: 90, child: Text(e.key)),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: fraction,
                      child: Container(
                        height: 14,
                        decoration: BoxDecoration(
                          // default color – do not specify a custom color
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('₹${e.value.toStringAsFixed(0)}'),
            ],
          ),
        );
      }).toList(),
    );
  }
}
