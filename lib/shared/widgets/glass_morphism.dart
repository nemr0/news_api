import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/shared/cubits/brightness_cubit/brightness_cubit.dart';

/// Glass Morphism Effect for news images
class GlassMorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final Widget child;

  const GlassMorphism({
    Key? key,
    this.blur = 5,
    this.opacity = .4,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationCubit, CupertinoThemeData>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur,
              sigmaY: blur,
              tileMode: TileMode.mirror,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.activeOrange.withOpacity(opacity),
                // state.brightness == Brightness.light
                //     ? CupertinoColors.darkBackgroundGray.withOpacity(opacity)
                //     : CupertinoColors.white.withOpacity(opacity),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: state.brightness == Brightness.light
                      ? CupertinoColors.darkBackgroundGray.withOpacity(.1)
                      : CupertinoColors.white.withOpacity(.2),
                  width: 1.5,
                ),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
