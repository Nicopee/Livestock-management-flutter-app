import 'package:flutter/material.dart';
import 'package:livestockapp/ui/screens/screens.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
          ),
          unselectedWidgetColor: Color.fromARGB(80, 51, 51, 51),
          shadowColor: const Color(0xFFe6e6e6).withOpacity(0.5),
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
        ),
        home: LoginPage());
  }
}

// GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         home: ManagerScreen());

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoginPage());
  }
}
