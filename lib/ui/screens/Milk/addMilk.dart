import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './milkScreen.dart';
import '../../../models/milkModel.dart';
import 'package:http/http.dart' as http;
import 'package:livestockapp/constants/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:shared_preferences/shared_preferences.dart';

class Milk extends StatefulWidget {
  const Milk({Key key}) : super(key: key);

  @override
  State<Milk> createState() => _MilkState();
}

class _MilkState extends State<Milk> {
  String role = "";
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString("role");
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

  Future<MilkModel> getMilk() async {
    var _url = Uri.parse(baseURL + 'milk');
    final response = await http.get(_url, headers: headers);
    final String responseData = response.body;
    return milkModelFromJson(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: role == "manager" ? true : false,
        child: FloatingActionButton.extended(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Get.to(() => const MilkScreen(),
                  fullscreenDialog: true,
                  transition: Transition.zoom,
                  duration: const Duration(microseconds: 500000));
            },
            label: const Text('Add Milk')),
      ),
      appBar: AppBar(
          title: const Text('Milk',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: FutureBuilder<MilkModel>(
        future: getMilk(),
        builder: (context, snapshot) {
          final _data = snapshot.data?.data;
          if (snapshot.hasData) {
            return SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: _data?.length,
                  itemBuilder: (context, index) {
                    final incomeData = _data[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Container(
                          height: 160,
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
                                        'Total Milk :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        incomeData.totalMilk.toString() +
                                            ' ' +
                                            'Litres',
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Cow Milked :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        incomeData.cattle.name,
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
                                        'Cow Breed :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        incomeData.cattle.breed.breed,
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
                                        'Milk date :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        timeago.format(incomeData.milkingDate),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Description :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        incomeData.description,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
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
