import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_api/modules/business/business_screen.dart';
import 'package:news_api/modules/science/science_screen.dart';
import 'package:news_api/modules/settings/settings_screen.dart';
import 'package:news_api/modules/sports/sports_screen.dart';
import 'package:news_api/shared/cubits/brightness_cubit/brightness_cubit.dart';
import 'package:news_api/shared/cubits/news_cubit/news_cubit.dart';

import '../shared/news_enum.dart';
import '../shared/triggers/on_my_profile.dart';

/// Designed in iOS Cupertino
/// contains: Cupertino Navigation Bar(Usually AppBar in MaterialApp),
/// CupertinoTabBar(Usually BottomNavigationBar in MaterialApp)
class HomeLayout extends HookWidget {
  const HomeLayout({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const List<String> kLabels = [
      'Business',
      'Sports',
      'Science',
      'Settings',
    ];

    final List<Widget> screens = [
      const BusinessScreen(),
      const SportsScreen(),
      const ScienceScreen(),
      const SettingsScreen(),
    ];
    final index = useState<int>(0);
    // Providing Navigation index BLoC
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: const CupertinoButton(
          onPressed: launchMyProfile,
          child: Icon(
            CupertinoIcons.exclamationmark_circle,
            size: 22,
          ),
        ),
        middle: Text(
          kLabels[index.value],
        ),
      ),
      child: CupertinoTabScaffold(
        // appBar: AppBar(
        //   title: Text(title),
        // ),
        tabBar: CupertinoTabBar(
          currentIndex: index.value,
          height: size.height * .07,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.building_2_fill), label: 'Business'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.sportscourt_fill), label: 'Sports'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.lab_flask_solid), label: 'Science'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Settings'),
          ],
          onTap: (newIndex) {
            if (newIndex < 3) {
              NewsType news = NewsType.values[newIndex];
              NewsCubit.get(context).getData(news: news);
            }
            index.value = newIndex;
          },
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(builder: (BuildContext context) {
            return Stack(children: [
              SvgPicture.asset('assets/${kLabels[index].toLowerCase()}.svg',
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.contain,
                  color: ConfigurationCubit.get(context).state.brightness ==
                          Brightness.dark
                      ? CupertinoColors.darkBackgroundGray
                      : CupertinoColors.inactiveGray.withOpacity(.1)
                  // color: kCupertinoModalBarrierColor,
                  ),
              SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: screens[index]),
            ]);
          });
        },
      ),
    );
  }
}
