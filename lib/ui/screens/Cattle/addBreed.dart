import 'package:flutter/material.dart';
import 'package:livestockapp/common/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'package:livestockapp/constants/constants.dart';
import 'package:get/get.dart';
import '../../screens/Settings/screens/cattleBreeds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBreed extends StatefulWidget {
  const AddBreed({Key key}) : super(key: key);

  @override
  State<AddBreed> createState() => _AddBreedState();
}

class _AddBreedState extends State<AddBreed> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController breedController = TextEditingController();

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

  Future addBreed() async {
    setState(() {
      _isLoading = true;
    });

    var _url = Uri.parse(constants[0].url + 'cattleBreed');
    final response = await http.post(_url,
        body: {
          'breed': breedController.text,
        },
        headers: headers);
    final String responseData = response.body;
    if (response.statusCode == 200) {
      Get.to(() => const CattleBreed(),
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
        title: const Text('Add Breed'),
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
                    controller: breedController,
                    onSaved: (value) {
                      breedController.text = value;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Breed is required';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Breed', 'Enter your breed'),
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
                            addBreed();
                          }
                        },
                      ),
                    ),
            ],
          )),
    );
  }
}
