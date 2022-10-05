import 'package:flutter/material.dart';

class IncomeCategories extends StatefulWidget {
  const IncomeCategories({Key? key}) : super(key: key);

  @override
  State<IncomeCategories> createState() => _IncomeCategoriesState();
}

class _IncomeCategoriesState extends State<IncomeCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange,
          onPressed: () {},
          label: const Text('Add Income')),
      appBar: AppBar(
          title: const Text('Incomes',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
    );
  }
}
