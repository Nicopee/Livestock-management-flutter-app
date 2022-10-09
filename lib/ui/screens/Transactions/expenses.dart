import 'package:flutter/material.dart';
import '../../../models/expenseModel.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import './addExpense.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  String role = "";
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
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
      };

  Future<ExpenseModel> getAllExpenses() async {
    var _url = Uri.parse(constants[0].url + 'expenses');
    final response = await http.get(_url, headers: headers);
    final String responseData = response.body;
    return expenseModelFromJson(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: role == "manager" ? true : false,
        child: FloatingActionButton.extended(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Get.to(
                () => AddExpenses(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            label: const Text('Add Expense')),
      ),
      body: FutureBuilder<ExpenseModel>(
        future: getAllExpenses(),
        builder: (context, snapshot) {
          final _data = snapshot.data?.data;
          if (snapshot.hasData) {
            return SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: _data?.length,
                  itemBuilder: (context, index) {
                    final incomeData = _data![index];
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Container(
                          height: 124,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Amount Spent :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        incomeData.amountSpent.toString(),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Expense Type :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        incomeData.expenseTypes.expenseType,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Added :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        timeago.format(incomeData.expenseDate),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
