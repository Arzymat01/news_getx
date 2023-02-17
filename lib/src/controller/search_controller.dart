import 'package:get/get.dart';
import 'package:news_getx/src/services/fetch_service.dart';

import '../models/top_news.dart';

class SearchCtl extends GetxController {
  Rx<TopNews?> topNews = Rxn();
  bool isSearch = false;

  Future<void> fetchData(String text) async {
    isSearch = true;
    topNews.value = await NewsRepo().fetchSearchNews(text);
    isSearch = false;
  }
}
