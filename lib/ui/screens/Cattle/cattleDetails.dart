import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CattleDetails extends StatefulWidget {
  const CattleDetails({Key? key}) : super(key: key);

  @override
  State<CattleDetails> createState() => _CattleDetailsState();
}

class _CattleDetailsState extends State<CattleDetails> {
  final _cattleDetails = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Cattle Details',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                child: GestureDetector(
                  child: Container(
                    height: 200,
                    // width: 23,
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(_cattleDetails[0]),
                          fit: BoxFit.fill),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Breed',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(_cattleDetails[1].toString())
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(_cattleDetails[2])
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Age',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(_cattleDetails[3].toString() + " " + "Years")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(_cattleDetails[5])
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Weight',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(_cattleDetails[6].toString())
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(_cattleDetails[4],
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
