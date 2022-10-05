import 'package:flutter/material.dart';

class ExpenseCategories extends StatefulWidget {
  const ExpenseCategories({Key? key}) : super(key: key);

  @override
  State<ExpenseCategories> createState() => _ExpenseCategoriesState();
}

class _ExpenseCategoriesState extends State<ExpenseCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange,
          onPressed: () {},
          label: const Text('Add Expense')),
      appBar: AppBar(
          title: const Text('Expenses',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
    );
  }
}
