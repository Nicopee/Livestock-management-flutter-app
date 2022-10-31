import 'package:flutter/material.dart';
import 'package:livestockapp/common/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'package:livestockapp/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './expenseCategory.dart';

class AddExpenseType extends StatefulWidget {
  const AddExpenseType({Key key}) : super(key: key);

  @override
  State<AddExpenseType> createState() => _AddExpenseTypeState();
}

class _AddExpenseTypeState extends State<AddExpenseType> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController expenseController = TextEditingController();

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
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      };

  Future addExpense() async {
    setState(() {
      _isLoading = true;
    });

    var _url = Uri.parse(constants[0].url + 'expenseTypes');
    final response = await http.post(_url,
        body: {
          'expense_type': expenseController.text,
        },
        headers: headers);
    final String responseData = response.body;
    if (response.statusCode == 200) {
      Get.to(() => const ExpenseCategories(),
          fullscreenDialog: true,
          transition: Transition.zoom,
          duration: const Duration(microseconds: 500000));
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Error  ', 'Network Error');
    }

    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense Category'),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: TextFormField(
                    controller: expenseController,
                    onSaved: (value) {
                      expenseController.text = value;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Expense Category is required';
                      }
                      return null;
                    },
                    decoration: ThemeHelper().textInputDecoration(
                        'Expense Category', 'Enter expense category'),
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
              ),
              const SizedBox(height: 30.0),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        // ignore: prefer_const_constructors
                        child: Padding(
                          // ignore: prefer_const_constructors
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          // ignore: prefer_const_constructors
                          child: Text(
                            'Save',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            addExpense();
                          }
                        },
                      ),
                    ),
            ],
          )),
    );
  }
}
