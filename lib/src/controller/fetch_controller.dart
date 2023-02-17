import 'package:get/get.dart';

import '../models/top_news.dart';
import '../services/fetch_service.dart';

class Fetcontroller extends GetxController {
  Rxn<TopNews?> topNews = Rxn();

  Future<void> fetchNews([String? domain]) async {
    topNews.value = await NewsRepo().fetchTopNews(domain);
  }

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }
}
