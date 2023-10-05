import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

/// Generates a unique identifier using the Uuid package.
const uuid = Uuid();

/// A [DateFormat] instance for formatting dates in the format "MM/dd/yyyy".
final formatter = DateFormat.yMd();

/// An enumeration representing the categories of expenses.
/// The categories are food, transportation, leisure, and work.
enum Category { food, transportation, leisure, work }

/// A map of category names to their corresponding icons.
const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.transportation: Icons.directions_car,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

/// A class representing an expense.
class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate => formatter.format(date);
}

/// A class representing an expense bucket.
class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses =>
      expenses.fold(0, (sum, expense) => sum + expense.amount);
}
