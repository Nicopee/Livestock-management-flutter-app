import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './uploadCattle.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../../models/cattleModel.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:shared_preferences/shared_preferences.dart';
import './cattleDetails.dart';

class Cattle extends StatefulWidget {
  const Cattle({Key? key}) : super(key: key);

  @override
  State<Cattle> createState() => _CattleState();
}

class _CattleState extends State<Cattle> {
  String role = "";
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString("role")!;
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

  Future<CattleModel> getCattle() async {
    var _url = Uri.parse(constants[0].url + 'cattle');
    final response = await http.get(_url, headers: headers);
    final String responseData = response.body;
    return cattleModelFromJson(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: role == "manager" ? true : false,
        child: FloatingActionButton.extended(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Get.to(
                () => const UploadCattle(),
                fullscreenDialog: true,
                transition: Transition.zoom,
              );
            },
            label: const Text('Add Cattle')),
      ),
      appBar: AppBar(
          title: const Text('Cattle',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: FutureBuilder<CattleModel>(
        future: getCattle(),
        builder: (context, snapshot) {
          final _data = snapshot.data?.data;
          if (snapshot.hasData) {
            return SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: _data?.length,
                  itemBuilder: (context, index) {
                    final incomeData = _data![index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const CattleDetails(),
                            fullscreenDialog: true,
                            transition: Transition.zoom,
                            arguments: [
                              incomeData.cattleImage,
                              incomeData.breed.breed,
                              incomeData.gender,
                              incomeData.age,
                              incomeData.description,
                              incomeData.name,
                              incomeData.weight
                            ]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Container(
                          height: 100,
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
                                        'Name :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        incomeData.name.toString(),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Tag No :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        incomeData.tagNo,
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
                                        'Added :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        timeago.format(incomeData.createdAt),
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
