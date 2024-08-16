import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/BOs/News.dart';
import 'package:weather_app/Services/URLLauncher/URLLauncher.dart';

class NewsWidget extends StatelessWidget {
  final News newsData;
  const NewsWidget({super.key, required this.newsData});

  @override
  Widget build(BuildContext context) {
    final URLLauncher urlLauncher = GetIt.instance<URLLauncher>();
    return ListTile(
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            newsData.urlToImage ?? "",
            height: 80.h,
            width: 80.w,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/images/news.png",
                  height: 80.h, width: 80.w, fit: BoxFit.contain);
            },
          )),
      title: Text(
        newsData.title ?? "",
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(newsData.sourceName ?? ""),
      trailing: IconButton(
          onPressed: () {
            urlLauncher.launchIncomingUrl(url: newsData.url ?? "");
          },
          icon: Image.asset(
            "assets/images/link.png",
            height: 30.h,
            color: Colors.blue.shade200,
          )),
    );
  }
}
