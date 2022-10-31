import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livestockapp/pages/login_page.dart';
import 'package:livestockapp/pages/agentLogin.dart';

class ChooseUser extends StatefulWidget {
  const ChooseUser({Key key}) : super(key: key);

  @override
  State<ChooseUser> createState() => _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: FractionalOffset(0, 0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => const AgentLoginPage(),
                    fullscreenDialog: true,
                    transition: Transition.zoom,
                    duration: const Duration(microseconds: 500000));
              },
              child: Container(
                  margin: const EdgeInsets.all(30),
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text("Farm Owner",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.none)),
                      ),
                    ),
                  ) // This trailing comma makes auto-formatting nicer for build methods.
                  ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const LoginPage(),
                    fullscreenDialog: true,
                    transition: Transition.zoom,
                    duration: const Duration(microseconds: 500000));
              },
              child: Container(
                  margin: const EdgeInsets.all(30),
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text("Farm Manager",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.none)),
                      ),
                    ),
                  ) // This trailing comma makes auto-formatting nicer for build methods.
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
