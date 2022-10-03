import 'package:flutter/material.dart';
import 'package:livestockapp/ui/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:livestockapp/ui/screens/screens.dart';
import 'package:get/get.dart';
import 'package:livestockapp/constants/constants.dart';
import 'package:livestockapp/pages/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String tokens = "";
  final TextEditingController trackFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokens = prefs.getString("token")!;
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
        "Authorization": "Bearer $tokens",
      };

  // Future<Packages> getPackages(String package) async {
  //   var _url;
  //   if (package == "all") {
  //     _url = Uri.parse(constants[0].url + 'package/get/all');
  //   } else {
  //     _url = Uri.parse(constants[0].url + 'package/' + package);
  //   }
  //   final response = await http.get(_url, headers: headers);
  //   final String responseData = response.body;
  //   print(responseData);
  //   return packagesFromJson(responseData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                left: 24,
              ),
              child: Text(
                'All parcels',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            centerTitle: false,
            floating: true,
            snap: false,
            pinned: true,
            titleSpacing: 0,
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(ProfilePage());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(''),
                    ),
                  ),
                ),
              ),
            ],
            shadowColor: Colors.transparent,
            expandedHeight: 426,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 64,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 48,
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Track parcel',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                style: Theme.of(context).textButtonTheme.style,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(
              top: 32,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My parcels',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
