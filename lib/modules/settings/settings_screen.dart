import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/shared/cubits/brightness_cubit/brightness_cubit.dart';

import '../../shared/triggers/on_my_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<ConfigurationCubit, CupertinoThemeData>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(
                    'Dark Mode',
                    style: TextStyle(
                        color: state.brightness == Brightness.dark
                            ? CupertinoColors.white
                            : CupertinoColors.black),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: state.brightness == Brightness.dark ? true : false,
                    onChanged: (isDark) async {
                      debugPrint(
                          'setTheme success? ${await ConfigurationCubit.get(context).setTheme(isDark)}');
                    },
                  ),
                ],
              );
            },
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'This App is Built using efforts of a',
                style: const TextStyle(
                    color: CupertinoColors.inactiveGray,
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
                children: [
                  TextSpan(
                      text: ' HUMAN ',
                      style: TextStyle(
                          fontSize: 20,
                          color: CupertinoColors.activeOrange.withOpacity(.8))),
                  const TextSpan(text: 'being.\n'),
                  const TextSpan(text: 'So, please be'),
                  TextSpan(
                      text: ' THOUGHTFUL ',
                      style: TextStyle(
                          fontSize: 20,
                          color: CupertinoColors.activeOrange.withOpacity(.8))),
                  const TextSpan(text: 'and'),
                  TextSpan(
                      text: ' HELPFUL.',
                      style: TextStyle(
                          fontSize: 20,
                          color: CupertinoColors.activeOrange.withOpacity(.8))),
                  const TextSpan(
                    text: '\nby Omar Elnemr',
                    style: TextStyle(fontSize: 16, color: CupertinoColors.link),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 40,
              width: 100,
              child: CupertinoButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: launchMyProfile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.exclamationmark_circle,
                        size: 22,
                        color: CupertinoColors.black,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'visit me?',
                        style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.darkBackgroundGray),
                      ),
                    ],
                  )),
            ),
          ),
          BlocBuilder<ConfigurationCubit, CupertinoThemeData>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .2,
                    vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            ConfigurationCubit.get(context).state.brightness ==
                                    Brightness.dark
                                ? CupertinoColors.lightBackgroundGray
                                : CupertinoColors.darkBackgroundGray),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'built w/ ❤ & 👨‍💻 & ️',
                      style: TextStyle(
                          color: CupertinoColors.inactiveGray,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FlutterLogo(
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
