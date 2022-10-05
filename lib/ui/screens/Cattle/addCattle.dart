import 'package:flutter/material.dart';

class Cattle extends StatefulWidget {
  const Cattle({Key? key}) : super(key: key);

  @override
  State<Cattle> createState() => _CattleState();
}

class _CattleState extends State<Cattle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange,
          onPressed: () {},
          label: const Text('Add Cattle')),
      appBar: AppBar(
          title: const Text('Cattle',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
    );
  }
}
