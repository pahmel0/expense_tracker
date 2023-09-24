import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('${expense.amount.toStringAsFixed(2)} kr'),
                const Spacer(),
                Row(children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(expense.date.toString()),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
