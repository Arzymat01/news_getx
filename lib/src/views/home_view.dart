import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_getx/src/constants/contry_domain.dart';
import 'package:news_getx/src/controller/fetch_controller.dart';
import 'package:news_getx/src/models/articles.dart';
import 'package:news_getx/src/models/top_news.dart';
import 'package:news_getx/src/views/detail_view.dart';
import 'package:news_getx/src/views/search_view.dart';

import '../components/news_card.dart';

import '../constants/app_text.dart';
import '../services/fetch_service.dart';
import '../theme/app_colors.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final ctl = Get.put(Fetcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.appBarText),
        backgroundColor: AppColors.appBar,
        actions: [
          PopupMenuButton(
            onSelected: (Country item) async {
              await ctl.fetchNews(item.domain);
            },
            itemBuilder: (context) {
              return countrySet
                  .map(
                    (e) => PopupMenuItem<Country>(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      ),
      body: Obx(() {
        return ctl.topNews.value == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: ctl.topNews.value?.articles.length ?? 0,
                itemBuilder: (context, index) {
                  final news = ctl.topNews.value!.articles[index];
                  return NewsCard(news: news);
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchView(),
          ),
        ),
        backgroundColor: AppColors.appBar,
        child: const Icon(Icons.search),
      ),
    );
  }
}
