import 'package:flutter/material.dart';
import 'package:livestockapp/ui/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:livestockapp/ui/screens/screens.dart';
import 'package:get/get.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:livestockapp/pages/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './incomes.dart';
import './expenses.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String tokens = "";
  final TextEditingController trackFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokens = prefs.getString("token")!;
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

  // Future<Packages> getPackages(String package) async {
  //   var _url;
  //   if (package == "all") {
  //     _url = Uri.parse(constants[0].url + 'package/get/all');
  //   } else {
  //     _url = Uri.parse(constants[0].url + 'package/' + package);
  //   }
  //   final response = await http.get(_url, headers: headers);
  //   final String responseData = response.body;
  //   print(responseData);
  //   return packagesFromJson(responseData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
          title: const Text('Transactions',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const TabBar(
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Income',
                    ),
                    Tab(text: 'Expenses'),
                  ],
                ),
                Container(
                    height: MediaQuery.of(context).size.height /
                        1.4, //height of TabBarView
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: const TabBarView(
                        children: <Widget>[Incomes(), Expenses()]))
              ])),

      // ),
    ));
  }
}
