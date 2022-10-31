// ignore_for_file: unnecessary_new, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livestockapp/common/theme_helper.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import './transactions.dart';
import 'dart:convert';

class AddIncomes extends StatefulWidget {
  const AddIncomes({Key key}) : super(key: key);

  @override
  State<AddIncomes> createState() => _AddIncomesState();
}

class _AddIncomesState extends State<AddIncomes> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController incomedateController = TextEditingController();
  final TextEditingController incometypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool _isLoading = false;

  List incomeTypesList = [];
  String selectedIncomeType = '3';

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
    getIcomeTypes();
  }

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  Map<String, String> get newheaders => {
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      };

  DateTime _selectedDate = DateTime.now();

  Future addNewIncome() async {
    setState(() {
      _isLoading = true;
    });

    var _url = Uri.parse(constants[0].url + 'incomes');
    final response = await http.post(_url,
        body: {
          'income_date': _selectedDate.toString(),
          'amount_earned': amountController.text,
          'description': descriptionController.text,
          'income_type_id': selectedIncomeType,
        },
        headers: newheaders);
    final String responseData = response.body;
    if (response.statusCode == 200) {
      Get.to(() => const TransactionScreen(),
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

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  Future<String> getIcomeTypes() async {
    var _url = Uri.parse(constants[0].url + 'incomeTypes');
    final response = await http.get(_url, headers: headers);
    final String responseData = response.body;
    var data = json.decode(response.body);
    setState(() {
      incomeTypesList = data['data'];
    });
    return (responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Income'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            labelText: 'select incomes',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          isEmpty: selectedIncomeType == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: selectedIncomeType,
                              isDense: true,
                              onChanged: (newVal) {
                                setState(() {
                                  selectedIncomeType = newVal.toString();
                                });
                              },
                              items: incomeTypesList.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: Text(item['income_type']),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                            child: const Text('Add Income Date'),
                            onPressed: _pickDateDialog),
                        const SizedBox(height: 20),
                        // ignore: unnecessary_null_comparison
                        Text(_selectedDate ==
                                null //ternary expression to check if date is null
                            ? 'No date was chosen!'
                            : 'Income date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: amountController,
                            onSaved: (value) {
                              amountController.text = value;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Amount is required';
                              }
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                'Amount', 'Enter amount earned'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: descriptionController,
                            onSaved: (value) {
                              descriptionController.text = value;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                'Description', 'Enter description earned'),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "Add Income".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      addNewIncome();
                                    }
                                  },
                                ),
                              ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
