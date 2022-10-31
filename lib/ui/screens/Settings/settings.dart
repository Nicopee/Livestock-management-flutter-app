import 'package:flutter/material.dart';
import '../Settings/screens/incomeCategory.dart';
import '../Settings/screens/expenseCategory.dart';
import 'package:get/get.dart';
import '../Settings/screens/cattleBreeds.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.currency_lira_outlined,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    Get.to(
                      () => IncomeCategories(),
                      fullscreenDialog: true,
                      transition: Transition.zoom,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Income Categories',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            )),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => ExpenseCategories(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.currency_franc,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Expense Categories',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              )),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(
                () => const CattleBreed(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.currency_exchange,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Cattle Breeds',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
