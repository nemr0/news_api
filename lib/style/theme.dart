import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

final CupertinoThemeData darkCupertinoTheme = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: GoogleFonts.newsreader().fontFamily)),
    scaffoldBackgroundColor: CupertinoColors.black,
    primaryColor: CupertinoColors.activeOrange,
    primaryContrastingColor: CupertinoColors.systemYellow,
    brightness: Brightness.dark,
    barBackgroundColor: CupertinoColors.darkBackgroundGray);
final CupertinoThemeData lightCupertinoTheme = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: GoogleFonts.newsreader().fontFamily)),
    scaffoldBackgroundColor: CupertinoColors.white,
    primaryColor: CupertinoColors.activeOrange,
    primaryContrastingColor: CupertinoColors.systemYellow,
    brightness: Brightness.light,
    barBackgroundColor: CupertinoColors.lightBackgroundGray);
Color kLayersColor = CupertinoColors.inactiveGray.withOpacity(.3);
