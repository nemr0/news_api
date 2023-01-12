import 'package:flutter/cupertino.dart';

/// if there's no included image url or on error loading image this appears
class ErrorImage extends StatelessWidget {
  const ErrorImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/error_image.png'));
  }
}
