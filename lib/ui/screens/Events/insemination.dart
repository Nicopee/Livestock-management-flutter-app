import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:livestockapp/constants/constants.dart';
import 'dart:convert';
import 'package:livestockapp/common/theme_helper.dart';
import 'package:intl/intl.dart';
import './addEvent.dart';

class Insemination extends StatefulWidget {
  const Insemination({Key key}) : super(key: key);

  @override
  State<Insemination> createState() => _InseminationState();
}

class _InseminationState extends State<Insemination> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController totalMilkController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCow = '11';
  List cattleList = [];
  DateTime _selectedDate = DateTime.now();

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
    getCattle();
    loadData();
  }

  Map<String, String> get headers => {
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      };

  Map<String, String> get newheaders => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  Future<String> getCattle() async {
    var _url = Uri.parse(baseURL + 'cattle');
    final response = await http.get(_url, headers: newheaders);
    final String responseData = response.body;
    var data = json.decode(response.body);
    setState(() {
      cattleList = data['data'];
    });
    return (responseData);
  }

  Future addInsemination() async {
    setState(() {
      _isLoading = true;
    });

    var _url = Uri.parse(baseURL + 'inseminations');
    final response = await http.post(_url,
        body: {
          'insemination_date': _selectedDate.toString(),
          'description': descriptionController.text,
          'cattle_id': selectedCow,
        },
        headers: headers);
    final String responseData = response.body;
    if (response.statusCode == 200) {
      Get.to(() => const Events(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('New Insemination',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    labelText: 'select cow',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  isEmpty: selectedCow == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: selectedCow,
                      isDense: true,
                      onChanged: (newVal) {
                        setState(() {
                          selectedCow = newVal.toString();
                        });
                      },
                      items: cattleList.map((item) {
                        return DropdownMenuItem(
                          value: item['id'].toString(),
                          child: Text(item['name']),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                  child: const Text('Add Insemination Date'),
                  onPressed: _pickDateDialog),
              const SizedBox(height: 20),
              // ignore: unnecessary_null_comparison
              Text(_selectedDate ==
                      null //ternary expression to check if date is null
                  ? 'No date was chosen!'
                  : 'Insemination date: ${DateFormat.yMMMd().format(_selectedDate)}'),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: TextFormField(
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                    onSaved: (value) {
                      descriptionController.text = value;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'description is required';
                      }
                      return null;
                    },
                    decoration: ThemeHelper().textInputDecoration(
                        'Description', 'Enter description'),
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
                            addInsemination();
                          }
                        },
                      ),
                    ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
