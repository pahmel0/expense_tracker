import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

/// A stateful widget that displays a list of expenses.
///
/// This widget is used to display a list of expenses in the expense tracker app.
/// It is a stateful widget because the list of expenses can change based on user input.
/// The widget is located in the `widgets` directory and the file path is `c:\Users\manta\AndroidStudioProjects\expense_tracker\lib\widgets\expenses.dart`.
class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

/// The private state class for the [Expenses] widget.

class _ExpensesState extends State<Expenses>
    with SingleTickerProviderStateMixin {
  /// The list of expenses that are registered in the app.
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 199,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema ticket',
        amount: 150,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  /// Opens the overlay for adding a new expense.
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  /// Adds an [Expense] to the list of expenses.
  void _addExpense(Expense expense) {
    // implementation details

    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //Animattion Controller
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  //Animation Controller

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Row(
          children: [
            // TODO: Fix the animation
            const CircularProgressIndicator(
              //value: _animation.value,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 250, 247, 247)),
            ),
            const SizedBox(width: 16),
            Text('${expense.title} removed'),
          ],
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  /// Builds the widget UI of the expenses widget.This is the first widget that is rendered in the app.
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses added yet. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: mainContent,
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 300,
                  child: Chart(expenses: _registeredExpenses),
                ),
              ],
            ),
    );
  }
}
