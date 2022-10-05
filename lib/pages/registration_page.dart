import 'package:flutter/material.dart';
import 'package:livestockapp/common/theme_helper.dart';
import 'package:livestockapp/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  bool _isLoading = false;
  bool _passwordVisible2 = false;
  bool _passwordVisible = false;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();

  Future register() async {
    setState(() {
      _isLoading = true;
    });
    var _url = Uri.parse(constants[0].url + 'managers');
    final response = await http.post(_url, body: {
      'firstname': firstnameController.text,
      'lastname': lastnameController.text,
      'contact': contactController.text,
      'email': emailController.text,
      'password': passwordController.text
    });
    final String responseData = response.body;
    if (response.statusCode == 200) {
      Get.to(() => const LoginPage(),
          fullscreenDialog: true,
          transition: Transition.zoom,
          duration: const Duration(microseconds: 500000));
      Get.snackbar('success', 'Manager Registered');
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Error  ', 'Email Already Exists');
    }
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Manager'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                        Container(
                          child: TextFormField(
                            controller: firstnameController,
                            onSaved: (value) {
                              firstnameController.text = value!;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Firstname is required';
                              }
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                'First Name', 'Enter your first name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: lastnameController,
                            onSaved: (value) {
                              lastnameController.text = value!;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Lastname is required';
                              }
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Name', 'Enter your last name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'E-mail is required';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: contactController,
                            onSaved: (value) {
                              contactController.text = value!;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number", "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Contact is required';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: passwordController,
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: confirmpassController,
                            onSaved: (value) {
                              confirmpassController.text = value!;
                            },
                            obscureText: !_passwordVisible2,
                            decoration: InputDecoration(
                              labelText: "Confirm*",
                              hintText: "Confirm password",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible2 = !_passwordVisible2;
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please confirm your password";
                              } else if (confirmpassController.text !=
                                  passwordController.text) {
                                return "Please match your password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 15.0),
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
                                      "Register".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      register();
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
