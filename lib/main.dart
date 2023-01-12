// ignore: unnecessary_import
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_api/shared/cubits/brightness_cubit/brightness_cubit.dart';
import 'package:news_api/shared/cubits/news_cubit/news_cubit.dart';

import 'custom_bloc_observer.dart';
import 'layout/home_layout.dart';

/// The Statring point of your flutter app
Future<void> main() async => {
      await GetStorage.init(),
// changing bloc observer to a custom one in ./custom_bloc_observer.dart
      Bloc.observer = CustomBlocObserver(), runApp(const MyApp())
    };

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// Using [CupertinoApp] instead of [MaterialApp] to Implement
    /// iOS Design Pattern (Cupertino)
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ConfigurationCubit()..initiate(),
          ),
          BlocProvider(create: (context) => NewsCubit()..getData()),
        ],
        child: BlocBuilder<ConfigurationCubit, CupertinoThemeData>(
            builder: (context, state) {
          // BrightnessCubit.get(context)
          //     .setTheme(state.brightness == Brightness.dark ? true : false);
          // debugPrint(
          // 'is Dark Theme Enabled:${GetStorage().read('isDark').toString()}');
          return CupertinoApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: state,
              // Main Page
              home: const HomeLayout());
        }));
  }
}
