import 'package:flutter/material.dart';
import 'package:livestockapp/common/theme_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:livestockapp/constants/constants.dart';
import '../ui/screens/manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgentLoginPage extends StatefulWidget {
  const AgentLoginPage({Key key}) : super(key: key);

  @override
  _AgentLoginPageState createState() => _AgentLoginPageState();
}

class _AgentLoginPageState extends State<AgentLoginPage> {
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _passwordVisible = false;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String removeAllWhitespaces(String string) {
    return string.replaceAll(' ', '');
  }

  Future userLogin() async {
    setState(() {
      _isLoading = true;
    });

    var _url = Uri.parse(constants[0].url + 'admin/login');
    final response = await http.post(_url, body: {
      'username': userNameController.text,
      'password': passwordController.text,
    });
    final String responseData = response.body;
    final _decoder = jsonDecode(responseData);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _decoder['token']['access_token']);
      prefs.setString('firstname', _decoder['user']['firstname']);
      prefs.setString('lastname', _decoder['user']['lastname']);
      prefs.setString('phone_contact', _decoder['user']['phone_contact']);
      prefs.setString('email', _decoder['user']['email']);
      prefs.setString('role', _decoder['user']['role']);
      prefs.setBool('logged', true);

      Get.to(() => const ManagerScreen(),
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
      Get.snackbar('Error  ', 'Invalid Credentials');
    }

    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Farm Owner Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: userNameController,
                                  onSaved: (value) {
                                    userNameController.text = value;
                                  },
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Username is required';
                                    }
                                    return null;
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'User Name', 'Enter your user name'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: passwordController,
                                  onSaved: (value) {
                                    passwordController.text = value;
                                  },
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    hintText: "Enter your password",
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        // ignore: prefer_const_constructors
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2.0)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        // ignore: prefer_const_constructors
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2.0)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : Container(
                                      decoration: ThemeHelper()
                                          .buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            'Sign In'.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            userLogin();
                                          }
                                        },
                                      ),
                                    ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
