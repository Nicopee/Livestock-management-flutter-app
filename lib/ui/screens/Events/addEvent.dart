import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange,
          onPressed: () {},
          label: const Text('Add Event')),
      appBar: AppBar(
          title: const Text('Events',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
    );
  }
}
