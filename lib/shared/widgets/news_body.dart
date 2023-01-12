import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../cubits/news_cubit/news_cubit.dart';
import '../news_enum.dart';
import 'news_item.dart';

class NewsBody extends HookWidget {
  const NewsBody(
    this.data, {
    Key? key,
    this.news = NewsType.business,
  }) : super(key: key);
  final List? data;
  final NewsType news;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return CupertinoScrollbar(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: CustomScrollView(
          controller: scrollController,
          shrinkWrap: true,
          // controller: scrollController,
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async => await NewsCubit.get(context)
                  .getData(isRefresh: true, news: news),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => NewsItem(
                        title: data![index]['title'],
                        imageUrl: data![index]['urlToImage'],
                        description: data![index]['description'],
                        url: data![index]['url'],
                        date: data![index]['publishedAt']
                            .toString()
                            .substring(0, 10),
                      ),
                  childCount: data?.length ?? 0),
            ),
          ],
        ),
      ),
    );
  }
}
