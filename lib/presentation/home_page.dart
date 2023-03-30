import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/models/movie.dart';
import 'package:fluttersample1/presentation/search_page.dart';
import 'package:fluttersample1/presentation/widgets/tab_bar_widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';



class HomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    FlutterNativeSplash.remove();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100.h,
            title:  Text('Movie Tmdb',
              style: TextStyle(color: Colors.pink.shade500, fontSize: 25.sp),),
            actions: [
              IconButton(
                  onPressed: (){
                    Get.to(() => SearchPage(), transition: Transition.leftToRight);
                  }, icon: Icon(Icons.search, size: 30.w,))
            ],
            bottom: TabBar(
                tabs: [
                  Tab(text: 'Popular',),
                  Tab(text: 'UpComing',),
                  Tab(text: 'TopRated',),
                ]),
          ),
          body: TabBarView(
              children: [
                TabBarWidgets(Categories.popular, '1'),
                TabBarWidgets(Categories.upcoming, '2'),
                TabBarWidgets(Categories.top_rated, '3'),
              ]
          )
      ),
    );
  }
}