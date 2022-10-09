import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './addExpenseType.dart';
import '../../../../models/expenseTypes.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ExpenseCategories extends StatefulWidget {
  const ExpenseCategories({Key? key}) : super(key: key);

  @override
  State<ExpenseCategories> createState() => _ExpenseCategoriesState();
}

class _ExpenseCategoriesState extends State<ExpenseCategories> {
  String tokens = "";
  String role = "";

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokens = prefs.getString("token")!;
      role = prefs.getString("role")!;
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

  Future<ExpenseTypes> getExpenseCategories() async {
    var _url = Uri.parse(constants[0].url + 'expenseTypes');
    final response = await http.get(_url, headers: headers);
    final String responseData = response.body;
    return expenseTypesFromJson(responseData);
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
                () => const AddExpenseType(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            label: const Text('Add Expense Category')),
      ),
      appBar: AppBar(
          title: const Text('Expense Categories',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: FutureBuilder<ExpenseTypes>(
        future: getExpenseCategories(),
        builder: (context, snapshot) {
          final _data = snapshot.data?.data;
          if (snapshot.hasData) {
            return SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: _data?.length,
                  itemBuilder: (context, index) {
                    final data = _data![index];
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Text(data.expenseType
                                  .substring(0, 1)
                                  .toUpperCase())),
                          title: Text(data.expenseType),
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
