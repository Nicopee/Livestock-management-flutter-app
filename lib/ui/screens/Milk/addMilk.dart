import 'package:flutter/material.dart';

class Milk extends StatefulWidget {
  const Milk({Key? key}) : super(key: key);

  @override
  State<Milk> createState() => _MilkState();
}

class _MilkState extends State<Milk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange,
          onPressed: () {},
          label: const Text('Add Milk')),
      appBar: AppBar(
          title: const Text('Milk',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
    );
  }
}
