import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Helpers/AppConstants/AppConstants.dart';
import 'package:weather_app/Provider/NewsProvider.dart';
import 'package:weather_app/widgets/NewsTile.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNews();
    });
  }

  Future<void> _getNews() async {
    await Provider.of<NewsProvider>(context, listen: false)
        .getNewsBasedOnWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recommended News"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(Icons.chevron_left)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8).w,
          child: Consumer<NewsProvider>(builder: (context, newsProvider, _) {
            if (newsProvider.isLoading) {
              const CircularProgressIndicator();
            }
            return AnimationLimiter(
              child: ListView.separated(
                itemCount: AppConstants.news.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: NewsWidget(newsData: AppConstants.news[index]),
                      ))));
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24).r,
                    child: Column(
                      children: [
                        8.verticalSpace,
                        const Divider(),
                        8.verticalSpace,
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ));
  }
}
