import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './addIncome.dart';
import '../../../../models/incomeTypes.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class IncomeCategories extends StatefulWidget {
  const IncomeCategories({Key key}) : super(key: key);

  @override
  State<IncomeCategories> createState() => _IncomeCategoriesState();
}

class _IncomeCategoriesState extends State<IncomeCategories> {
  String tokens = "";
  String role = "";

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokens = prefs.getString("token");
      role = prefs.getString("role");
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

  Future<Incomes> getIncomes() async {
    var _url = Uri.parse(constants[0].url + 'incomeTypes');
    final response = await http.get(_url, headers: headers);
    final String responseData = response.body;
    return incomesFromJson(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: role == "manager" ? false : true,
        child: FloatingActionButton.extended(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Get.to(
                () => const AddIncome(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            label: const Text('Add Income Category')),
      ),
      appBar: AppBar(
          title: const Text('Incomes Categories',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: FutureBuilder<Incomes>(
        future: getIncomes(),
        builder: (context, snapshot) {
          final _data = snapshot.data?.data;
          if (snapshot.hasData) {
            return SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: _data?.length,
                  itemBuilder: (context, index) {
                    final data = _data[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Text(data.incomeType
                                  .substring(0, 1)
                                  .toUpperCase())),
                          title: Text(data.incomeType),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
