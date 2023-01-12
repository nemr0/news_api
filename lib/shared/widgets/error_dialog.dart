import 'package:flutter/cupertino.dart';

showErrorCupertinoDialog(BuildContext context, {required String? error}) {
  showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  CupertinoIcons.exclamationmark_circle_fill,
                  color: CupertinoColors.systemRed,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Error Launching URL!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: CupertinoColors.systemRed,
                  ),
                )
              ],
            ),
            content: Text(
              error ?? 'Unknown Error.',
              style: const TextStyle(color: CupertinoColors.systemRed),
            ),
          ));
}
