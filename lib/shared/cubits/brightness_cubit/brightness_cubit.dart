import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_api/style/theme.dart';

class ConfigurationCubit extends Cubit<CupertinoThemeData> {
  ConfigurationCubit() : super(darkCupertinoTheme);

  /// Getting Current bool
  @override
  CupertinoThemeData get state => super.state;

  /// on create
  /// gets saved theme.
  void initiate() {
    bool? isDark = GetStorage().read('isDark');
    debugPrint('isDark:$isDark');
    if (isDark == null || isDark == true) {
      emit(darkCupertinoTheme);
    } else if (isDark == false) {
      emit(lightCupertinoTheme);
    }
  }

  /// sets a new theme and saves it to get_storage
  Future<bool> setTheme(bool isDark) async {
    try {
      await GetStorage().write('isDark', isDark);
      emit(isDark ? darkCupertinoTheme : lightCupertinoTheme);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get Instance of this cubit using context
  static ConfigurationCubit get(BuildContext context) =>
      BlocProvider.of<ConfigurationCubit>(context);
}
