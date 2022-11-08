import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:livestockapp/common/theme_helper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:livestockapp/constants/constants.dart';
import './calves_list.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class AddCalf extends StatefulWidget {
  const AddCalf({Key key}) : super(key: key);

  @override
  State<AddCalf> createState() => _AddCalfState();
}

class _AddCalfState extends State<AddCalf> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagNoController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCow = '1';
  List cattleList = [];

  String tokens = "";
  File imageFile;
  List cattleBreedList = [];

  List genderList = [
    {'name': 'Male'},
    {'name': 'Female'}
  ];
  String selectedCattleBreed = '1';
  String selectedgender = 'Male';

  DateTime _selectedDate = DateTime.now();

  void loadData() async {
    getCattleBreeds();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokens = prefs.getString("token");
    });
  }

  Map<String, String> get newheaders => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  Map<String, String> get headers => {
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      };

  Future<String> getCattleBreeds() async {
    var _url = Uri.parse(baseURL + 'cattleBreed');
    final response = await http.get(_url, headers: newheaders);
    final String responseData = response.body;
    var data = json.decode(response.body);
    setState(() {
      cattleBreedList = data['data'];
    });
    return (responseData);
  }

  Future addNewCalf(File photoFile) async {
    setState(() {
      _isLoading = true;
    });
    var _url = Uri.parse(baseURL + 'calfs');
    var dio = Dio();
    dio.options.headers = headers;
    String fileName = photoFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "cattle_image":
          await MultipartFile.fromFile(photoFile.path, filename: fileName),
      'name': nameController.text,
      'tag_no': tagNoController.text,
      'cattle_id': selectedCow,
      'weight': weightController.text,
      'date_of_birth': _selectedDate.toString(),
      'description': descriptionController.text,
      'gender': selectedgender,
      'cattle_breed_id': selectedCattleBreed
    });

    var response = await dio.post(
      _url.toString(),
      data: formData,
    );
    try {
      if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CalvesList(),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });

      const SnackBar(
        content: Text("Network Error"),
        duration: Duration(milliseconds: 3000),
      );
    }
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

  @override
  void initState() {
    super.initState();
    getCattle();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Add New Calf'),
        centerTitle: true,
      ),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    labelText: 'select cattle breed',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  isEmpty: selectedCattleBreed == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: selectedCattleBreed,
                      isDense: true,
                      onChanged: (newVal) {
                        setState(() {
                          selectedCattleBreed = newVal.toString();
                        });
                      },
                      items: cattleBreedList.map((item) {
                        return DropdownMenuItem(
                          value: item['id'].toString(),
                          child: Text(item['breed']),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: TextFormField(
                    controller: nameController,
                    onSaved: (value) {
                      nameController.text = value;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Name', 'Enter name please'),
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: TextFormField(
                    controller: tagNoController,
                    onSaved: (value) {
                      tagNoController.text = value;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Tag No is required';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Tag No', 'Enter tag no'),
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
              ),
              RaisedButton(
                  child: const Text('Add Birth Date'),
                  onPressed: _pickDateDialog),
              const SizedBox(height: 20),
              // ignore: unnecessary_null_comparison
              Text(_selectedDate ==
                      null //ternary expression to check if date is null
                  ? 'No date was chosen!'
                  : 'Income date: ${DateFormat.yMMMd().format(_selectedDate)}'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: TextFormField(
                    controller: weightController,
                    onSaved: (value) {
                      weightController.text = value;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Weight is required';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Weight', 'Enter weight'),
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    labelText: 'select gender',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  isEmpty: selectedgender == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: selectedgender,
                      isDense: true,
                      onChanged: (newVal) {
                        setState(() {
                          selectedgender = newVal.toString();
                        });
                      },
                      items: genderList.map((item) {
                        return DropdownMenuItem(
                          value: item['name'],
                          child: Text(item['name']),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
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

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageFile != null)
                      Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              image: FileImage(imageFile), fit: BoxFit.cover),
                          border: Border.all(width: 1, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      )
                    else
                      const SizedBox(
                        height: 20,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () =>
                              getImage(source: ImageSource.gallery),
                          child: Text(
                              imageFile != null
                                  ? 'Replace Cattle Image'
                                  : 'Select Cattle Image',
                              style: const TextStyle(fontSize: 18))),
                    )
                  ],
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
                            imageFile != null
                                ? addNewCalf(imageFile)
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Please Upload Cattle Image"),
                                      duration: Duration(milliseconds: 3000),
                                    ),
                                  );
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

  void getImage({ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 640,
        maxHeight: 480,
        imageQuality: 70 //0 - 100
        );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }
}
