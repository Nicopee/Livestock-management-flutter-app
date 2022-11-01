import 'package:livestockapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:launch_review/launch_review.dart';

import '../models/version.dart';

class VersionUpdate extends StatefulWidget {
  @override
  _VersionUpdateState createState() => _VersionUpdateState();
}

class _VersionUpdateState extends State<VersionUpdate> {
  Version version;

  get largestButtonWidth => null;

  @override
  void initState() {
    super.initState();
    version = Get.arguments['version'];
  }

  Future<bool> _onWillPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.only(top: 25, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/app_logo.jpg',
                          ),
                          SizedBox(height: 20),
                          Text(
                            'V' + version.version,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: body),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'We have made adjustments to improve on your user experience',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: largestButtonWidth,
                            child: FlatButton(
                              color: primary,
                              // onPressed: () async {
                              //   LaunchReview.launch();
                              // },
                              child: Text(
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)),
                            ),
                          ),
                        ],
                      )),
                  if (version.isForced == null || !version.isForced)
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Text('SKIP',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4))),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ))
                ],
              ),
            )),
        onWillPop: _onWillPop);
  }
}
