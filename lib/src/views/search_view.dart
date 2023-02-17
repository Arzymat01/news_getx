import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_getx/src/constants/app_text.dart';

import 'package:news_getx/src/theme/app_colors.dart';

import '../components/news_card.dart';
import '../controller/search_controller.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final controller = TextEditingController();
  final ctl = Get.put(SearchCtl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: TextField(
          controller: controller,
          onChanged: ((value) async {
            await ctl.fetchData(value);
          }),
          decoration: const InputDecoration(
            fillColor: Color.fromARGB(255, 242, 240, 234),
            filled: true,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ctl.fetchData(controller.text);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Obx(() {
      if (ctl.isSearch) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (ctl.isSearch == false && ctl.topNews.value != null) {
        return ListView.builder(
          itemCount: ctl.topNews.value!.articles.length,
          itemBuilder: (context, index) {
            final news = ctl.topNews.value!.articles[index];
            return NewsCard(news: news);
          },
        );
      } else {
        return const Center(
          child: Text(AppText.searchtext),
        );
      }
    });
  }
}
