import 'package:livestockapp/models/feed.dart';
import 'package:livestockapp/repository/feed_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedController extends ChangeNotifier {
  List<Feed> feeds = [];
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

      List<Feed> results = await FeedRepository.getFeeds(nextPage, perPage);
      if (results.length < perPage) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      feeds.addAll(results);
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
      feeds = [];
      List<Feed> results = await FeedRepository.getFeeds(nextPage, perPage);

      if (results.length < perPage) {
        refreshController.loadNoData();
      }

      feeds.addAll(results);
    } catch (e) {
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
