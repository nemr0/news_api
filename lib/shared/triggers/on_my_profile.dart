import 'package:url_launcher/url_launcher.dart';

/// on visit me or (i) button press
launchMyProfile() => launchUrl(
      Uri.parse('https://linktr.ee/nemrdev'),
      mode: LaunchMode.inAppWebView,
    ).onError((error, stackTrace) => false);
