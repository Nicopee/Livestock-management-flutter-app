import 'package:flutter/material.dart';
import 'package:livestockapp/common/theme_helper.dart';
import 'package:livestockapp/controllers/feed_controller.dart';
import 'package:provider/provider.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import './feeds_list.dart';

class AddFeed extends StatefulWidget {
  const AddFeed({Key key}) : super(key: key);

  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  final TextEditingController feedController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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

  Future addNewFeed() async {
    setState(() {
      _isLoading = true;
    });

    var _url = Uri.parse(baseURL + 'feeds');
    final response = await http.post(_url,
        body: {
          'name': descriptionController.text,
          'description': descriptionController.text,
        },
        headers: headers);
    final String responseData = response.body;
    if (response.statusCode == 200) {
      Get.to(() => const FeedList(),
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
          title: const Text('Add Feed',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500))),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: TextFormField(
                    controller: feedController,
                    onSaved: (value) {
                      feedController.text = value;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'feed is required';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Feed', 'Enter feed received'),
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            addNewFeed();
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
