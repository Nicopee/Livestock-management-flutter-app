import 'package:flutter/material.dart';
import 'package:livestockapp/ui/screens/screens.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Cattle/addCattle.dart';
import '../screens/Milk/addMilk.dart';
import '../screens/Events/addEvent.dart';
import '../screens/Settings/settings.dart';
import '../screens/Calves/calves_list.dart';
import '../screens/Feeds/feeds_list.dart';
import 'package:livestockapp/ui/charts.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({Key key}) : super(key: key);

  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  final double _drawerIconSize = 24;
  final double _drawerFontSize = 17;
  String tokens = "";

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokens = prefs.getString("token");
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Farm Manager",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: <Color>[Colors.green, Colors.greenAccent])),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                0.0,
                1.0
              ],
                  colors: [
                Colors.white10,
                Colors.white12,
              ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Colors.white10,
                      Colors.white12,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Farm Manager",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.login_rounded,
                  size: _drawerIconSize,
                  color: Colors.black,
                ),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  size: _drawerIconSize,
                  color: Colors.black,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_add_alt_1,
                  size: _drawerIconSize,
                  color: Colors.black,
                ),
                title: Text(
                  'Registration Page',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Colors.black,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Colors.black,
                ),
                title: Text(
                  'Forgot Password Page',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Colors.black,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Colors.black,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  Get.to(() => const LoginPage(),
                      transition: Transition.zoom,
                      duration: const Duration(microseconds: 500000));
                },
              ),
            ],
          ),
        ),
      ),
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
                    Icons.ac_unit,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    Get.to(
                      () => const Cattle(),
                      fullscreenDialog: true,
                      transition: Transition.zoom,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Cattle',
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
                () => const Milk(),
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
                      Icons.receipt_outlined,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Milk Records',
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
                () => const TransactionScreen(),
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
                    'Transactions',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => const Events(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
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
                      Icons.event_available,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Insemination',
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
                () => const FeedList(),
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
                      Icons.fence,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Feeds',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => const CalvesList(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
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
                      Icons.kayaking,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Calves',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => const Settings(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
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
                      Icons.settings,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => const ChartReport(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
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
                      Icons.bar_chart_sharp,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Reports',
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
