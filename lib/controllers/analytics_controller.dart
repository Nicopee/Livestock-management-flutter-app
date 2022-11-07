import 'package:livestockapp/models/analytics.dart';
import 'package:livestockapp/repository/analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AnalyticsController extends ChangeNotifier {
  bool isLoading = true;
  bool isLoadingMore = true;
  dynamic exception;
  Analytics analytics;

  RefreshController refreshController;

  void getAnalyticsData() async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      analytics = await AnalyticsRepository.getAnalytics();
    } catch (e) {
      exception = e;
      analytics = null;
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    refreshController?.dispose();
    super.dispose();
  }
}
