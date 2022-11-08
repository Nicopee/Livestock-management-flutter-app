import 'package:livestockapp/constants/constants.dart';
import 'package:livestockapp/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:livestockapp/controllers/calves_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import './add_calves.dart';

class CalvesList extends StatefulWidget {
  const CalvesList({Key key}) : super(key: key);

  @override
  State<CalvesList> createState() => _CalvesListState();
}

class _CalvesListState extends State<CalvesList> {
  String role = "";
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString("role");
    });
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  CalvesController calvesController = CalvesController();

  @override
  void initState() {
    super.initState();
    calvesController.refreshController = refreshController;
    loadData();
    calvesController.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: calvesController,
        child: Consumer<CalvesController>(builder: (_, model, child) {
          return Scaffold(
            floatingActionButton: Visibility(
              visible: role == "manager" ? true : false,
              child: FloatingActionButton.extended(
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    Get.to(() => const AddCalf(),
                        fullscreenDialog: true,
                        transition: Transition.zoom,
                        duration: const Duration(microseconds: 500000));
                  },
                  label: const Text('Add Calf')),
            ),
            appBar: AppBar(
              title: const Text(
                'Calves',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: DefaultTextStyle.merge(
                  child: model.isLoading
                      ? Center(
                          child: LottieBuilder.asset(
                          'assets/loading.json',
                          height: 200,
                          width: 200,
                          animate: true,
                          repeat: true,
                        ))
                      : model.exception != null
                          ? AppErrorWidget(
                              retry: true,
                              exception: model.exception,
                              onTap: () {
                                model.fetch();
                              },
                            )
                          : model.calves.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: const Center(
                                        child: Text(
                                          'No calves available currently.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: title),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : SmartRefresher(
                                  controller: model.refreshController,
                                  enablePullDown: false,
                                  enablePullUp: true,
                                  physics: const BouncingScrollPhysics(),
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: model.calves.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 10);
                                    },
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Theme.of(context)
                                                        .focusColor
                                                        .withOpacity(0.1),
                                                    blurRadius: 5,
                                                    offset: Offset(0, 2)),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Name: ${model.calves[index].name}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Tag: ${model.calves[index].tagNo}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 100,
                                                          width: 100,
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      25,
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(model
                                                                    .calves[
                                                                        index]
                                                                    .cattleImage),
                                                                fit: BoxFit
                                                                    .fill),
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black,
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          2.0),
                                                                  blurRadius:
                                                                      6.0),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        const Text('Weight'),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(model.calves[index]
                                                            .weight),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                    'Offspring Of:'),
                                                                const SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(model
                                                                    .calves[
                                                                        index]
                                                                    .cattle
                                                                    .name)
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 14)
                                              ],
                                            )),
                                      );
                                    },
                                  ),
                                  onLoading: () => model.fetchMore(),
                                  footer:
                                      CustomFooter(builder: (context, mode) {
                                    if (mode == LoadStatus.idle) {
                                      return Container();
                                    } else if (mode == LoadStatus.loading) {
                                      return Center(
                                        child: LottieBuilder.asset(
                                          'assets/loading.json',
                                          height: 100,
                                          animate: true,
                                          repeat: true,
                                        ),
                                      );
                                    } else if (mode == LoadStatus.failed) {
                                      return GestureDetector(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.error,
                                                color: errorColor,
                                              ),
                                              const SizedBox(width: 20),
                                              const Text(
                                                'Retry',
                                                style: TextStyle(
                                                    fontSize: heading,
                                                    color: Colors.black),
                                              )
                                            ]),
                                        onTap: () {
                                          model.fetchMore();
                                        },
                                      );
                                    } else if (mode == LoadStatus.canLoading) {
                                      return Container();
                                    } else {
                                      return Container();
                                    }
                                  }),
                                ),
                  style: const TextStyle(color: Colors.black)),
            ),
          );
        }));
  }
}
