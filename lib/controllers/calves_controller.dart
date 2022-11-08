import 'package:livestockapp/models/calf.dart';
import 'package:livestockapp/repository/calves_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CalvesController extends ChangeNotifier {
  List<Calf> calves = [];
  int nextPage = 0;
  bool loadCart = false;
  bool isLoading = true;
  bool isLoadingMore = true;
  dynamic exception;
  RefreshController refreshController;
  int perPage = 15;
  void fetchMore() async {
    try {
      nextPage = nextPage + 1;

      List<Calf> results = await CalvesRepository.getCalves(nextPage, perPage);
      if (results.length < perPage) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      calves.addAll(results);
    } catch (_) {
      nextPage = nextPage - 1;
      refreshController.loadFailed();
    }

    notifyListeners();
  }

  void fetch() async {
    if (isLoading == false) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      calves = [];
      List<Calf> results = await CalvesRepository.getCalves(nextPage, perPage);

      if (results.length < perPage) {
        refreshController.loadNoData();
      }

      calves.addAll(results);
    } catch (e) {
      print(e);
      exception = e;
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
