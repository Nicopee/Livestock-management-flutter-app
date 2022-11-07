import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:livestockapp/controllers/analytics_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:livestockapp/ui/widgets/error_widget.dart';
import 'package:livestockapp/models/analytics.dart';
import 'package:livestockapp/repository/analytics_repository.dart';

class ChartReport extends StatefulWidget {
  final Widget child;

  const ChartReport({Key key, this.child}) : super(key: key);

  _ChartReportState createState() => _ChartReportState();
}

class _ChartReportState extends State<ChartReport> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  AnalyticsController analyticsController = AnalyticsController();

  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Sales, int>> _seriesLineData;

  Future<Analytics> getAnaly() async {
    try {
      Analytics analytics = await AnalyticsRepository.getAnalytics();
      _seriesPieData.add(
        charts.Series(
          domainFn: (Task task, _) => task.task,
          measureFn: (Task task, _) => task.taskvalue,
          colorFn: (Task task, _) =>
              charts.ColorUtil.fromDartColor(task.colorval),
          id: 'Air Pollution',
          data: [
            Task('Incomes', double.parse(analytics.totalIncomeAmount),
                const Color(0xff3366cc)),
            Task('Expenses', double.parse(analytics.totalExpenseAmount),
                const Color(0xff990099)),
          ],
          labelAccessorFn: (Task row, _) => '${row.taskvalue}',
        ),
      );
      return analytics;
    } catch (_) {
      rethrow;
    }
  }

  _generateData() {
    var data1 = [
      Pollution(1980, 'USA', 30),
      Pollution(1980, 'Asia', 40),
    ];
    var data2 = [
      Pollution(1985, 'USA', 100),
      Pollution(1980, 'Asia', 150),
    ];
    var data3 = [
      Pollution(1985, 'USA', 200),
      Pollution(1980, 'Asia', 300),
    ];

    var linesalesdata = [
      Sales(0, 45),
      Sales(1, 56),
      Sales(2, 55),
      Sales(3, 60),
      Sales(4, 61),
      Sales(5, 70),
    ];
    var linesalesdata1 = [
      Sales(0, 35),
      Sales(1, 46),
      Sales(2, 45),
      Sales(3, 50),
      Sales(4, 51),
      Sales(5, 60),
    ];

    var linesalesdata2 = [
      Sales(0, 20),
      Sales(1, 24),
      Sales(2, 25),
      Sales(3, 40),
      Sales(4, 45),
      Sales(5, 60),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(const Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(const Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(const Color(0xffff9900)),
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
    getAnaly();
    analyticsController.refreshController = refreshController;
    analyticsController.getAnalyticsData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: analyticsController,
        child: Consumer<AnalyticsController>(builder: (_, model, child) {
          return Scaffold(
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
                                model.getAnalyticsData();
                              },
                            )
                          : MaterialApp(
                              debugShowCheckedModeBanner: false,
                              home: DefaultTabController(
                                length: 2,
                                child: Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: const Color(0xff1976d2),
                                    bottom: const TabBar(
                                      indicatorColor: Color(0xff9962D0),
                                      tabs: [
                                        Tab(
                                            icon: Icon(
                                                FontAwesomeIcons.chartPie)),
                                        Tab(
                                            icon: Icon(
                                                FontAwesomeIcons.chartLine)),
                                      ],
                                    ),
                                    title: const Text("Report"),
                                  ),
                                  body: TabBarView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                const Text(
                                                  'Income & Expenses',
                                                  style: TextStyle(
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Expanded(
                                                  child: charts.PieChart(
                                                      _seriesPieData,
                                                      animate: true,
                                                      animationDuration:
                                                          const Duration(
                                                              seconds: 5),
                                                      behaviors: [
                                                        charts.DatumLegend(
                                                          outsideJustification:
                                                              charts
                                                                  .OutsideJustification
                                                                  .endDrawArea,
                                                          horizontalFirst:
                                                              false,
                                                          desiredMaxRows: 2,
                                                          cellPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 4.0,
                                                                  bottom: 4.0),
                                                          entryTextStyle: charts
                                                              .TextStyleSpec(
                                                                  color: charts
                                                                      .MaterialPalette
                                                                      .purple
                                                                      .shadeDefault,
                                                                  fontFamily:
                                                                      'Georgia',
                                                                  fontSize: 11),
                                                        )
                                                      ],
                                                      defaultRenderer: charts
                                                          .ArcRendererConfig(
                                                              arcWidth: 100,
                                                              arcRendererDecorators: [
                                                            charts.ArcLabelDecorator(
                                                                labelPosition:
                                                                    charts
                                                                        .ArcLabelPosition
                                                                        .inside)
                                                          ])),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              const Text(
                                                'Milk produced',
                                                style: TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: charts.LineChart(
                                                    _seriesLineData,
                                                    defaultRenderer: charts
                                                        .LineRendererConfig(
                                                            includeArea: true,
                                                            stacked: true),
                                                    animate: true,
                                                    animationDuration:
                                                        const Duration(
                                                            seconds: 5),
                                                    behaviors: [
                                                      charts.ChartTitle(
                                                          'last five days',
                                                          behaviorPosition: charts
                                                              .BehaviorPosition
                                                              .bottom,
                                                          titleOutsideJustification: charts
                                                              .OutsideJustification
                                                              .middleDrawArea),
                                                      charts.ChartTitle(
                                                          'Milk (litres)',
                                                          behaviorPosition: charts
                                                              .BehaviorPosition
                                                              .start,
                                                          titleOutsideJustification: charts
                                                              .OutsideJustification
                                                              .middleDrawArea),
                                                      charts.ChartTitle(
                                                        '',
                                                        behaviorPosition: charts
                                                            .BehaviorPosition
                                                            .end,
                                                        titleOutsideJustification:
                                                            charts
                                                                .OutsideJustification
                                                                .middleDrawArea,
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                  style: const TextStyle(color: Colors.black)),
            ),
          );
        }));
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
