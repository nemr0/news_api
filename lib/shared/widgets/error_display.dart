import 'package:flutter/cupertino.dart';

/// Error Handler loading Data
class ErrorDisplay extends StatelessWidget {
  final dynamic error;
  const ErrorDisplay({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            CupertinoIcons.exclamationmark_octagon_fill,
            color: CupertinoColors.systemRed,
            size: 60,
          ),
          Text(
            error.toString(),
            style: const TextStyle(
              color: CupertinoColors.systemRed,
            ),
          ),
        ],
      ),
    );
  }
}
