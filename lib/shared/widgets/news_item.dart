import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/shared/widgets/error_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../lorem_test.dart';
import 'error_dialog.dart';
import 'error_display.dart';

class NewsItem extends StatelessWidget {
  const NewsItem(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.url,
      required this.date})
      : super(key: key);
  final String? title;
  final String? imageUrl;
  final String? description;
  final String? url;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoContextMenu(
          actions: [
            CupertinoContextMenuAction(
              trailingIcon: Icons.web,
              child:
                  // Icon(Icons.web),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  const Text(
                'Open URL',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                if (url == null || (url?.isEmpty)!) {
                  showErrorCupertinoDialog(context, error: 'No Given URL.');
                } else {
                  launchUrl(Uri.parse(url!))
                      .catchError((error, stackTrace) async {
                    showErrorCupertinoDialog(context, error: error);
                  });
                }
              },
            ),
            CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.share_solid,
              child: const Text(
                'Share',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                if (url == null || (url?.isEmpty)!) {
                  showErrorCupertinoDialog(context, error: 'No Given URL.');
                } else {
                  Share.share(url!, subject: title ?? 'Whatever!')
                      .catchError((error, stackTrace) async {
                    showErrorCupertinoDialog(context, error: error);
                  });
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    color: CupertinoColors.activeOrange.withOpacity(.8),
                    // border: Border.all(
                    //     color: CupertinoColors.lightBackgroundGray
                    //         .withOpacity(.4),
                    //     width: 2),
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        imageUrl: imageUrl ?? tImageURL,
                        imageBuilder: (context, image) => Opacity(
                            opacity: .6,
                            child: Image(
                              image: image,
                              filterQuality: FilterQuality.high,
                            )),
                        progressIndicatorBuilder:
                            (context, s, downloadProgress) {
                          return const CupertinoActivityIndicator();
                        },
                        errorWidget: (context, s, error) => ErrorImage(),
                      ),
                    ),

                    // ExpansionPanelList(
                    //   children: [
                    //     ExpansionPanel(
                    //         headerBuilder: (context, i) => Text(
                    //               title ?? 'No Provided Title',
                    //               style: const TextStyle(
                    //                   color: CupertinoColors.darkBackgroundGray,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 24),
                    //             ),
                    //         body: Text(tContent)),
                    if (description == null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title ?? 'No Provided Title',
                          style: const TextStyle(
                              // color: CupertinoColors.darkBackgroundGray,
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                      ),
                    if (description != null)
                      Material(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: ExpansionTile(
                            collapsedBackgroundColor: Colors.transparent,
                            backgroundColor: CupertinoColors.white,
                            collapsedIconColor:
                                CupertinoColors.lightBackgroundGray,
                            iconColor: CupertinoColors.activeOrange,
                            collapsedTextColor:
                                CupertinoColors.lightBackgroundGray,
                            textColor: CupertinoColors.darkBackgroundGray,
                            title: Text(
                              title ?? 'No Provided Title',
                              style: const TextStyle(
                                  // color: CupertinoColors.darkBackgroundGray,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                date ?? '',
                                style: const TextStyle(
                                    color: CupertinoColors.lightBackgroundGray,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(description!),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                )),
          ),
        ));
  }
}
