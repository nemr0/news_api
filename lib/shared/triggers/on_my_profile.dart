import 'package:url_launcher/url_launcher.dart';

launchMyProfile() => launchUrl(
      Uri.parse('https://linktr.ee/nemrdev'),
      mode: LaunchMode.inAppWebView,
    ).onError((error, stackTrace) => false);
