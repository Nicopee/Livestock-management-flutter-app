import 'package:flutter/material.dart';

class CattleBreed extends StatefulWidget {
  const CattleBreed({Key? key}) : super(key: key);

  @override
  State<CattleBreed> createState() => _CattleBreedState();
}

class _CattleBreedState extends State<CattleBreed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange,
          onPressed: () {},
          label: const Text('Add Breed')),
      appBar: AppBar(
          title: const Text('Cattle Breeds',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
    );
  }
}
