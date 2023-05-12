import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Providers/single_walpaper_provider.dart';
import 'package:walpy_wallpapers/Services/api_services.dart';
import 'package:walpy_wallpapers/Widgets/nav_button.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:walpy_wallpapers/utils/toast.dart';

class SingleWalpaperScreen extends StatefulWidget {
  String walpaperUrl;
  String walpaperId;
  SingleWalpaperScreen(this.walpaperUrl, this.walpaperId, {super.key});

  @override
  State<SingleWalpaperScreen> createState() => _SingleWalpaperScreenState();
}

class _SingleWalpaperScreenState extends State<SingleWalpaperScreen> {
  final auth = FirebaseAuth.instance;
  int noOfDownloads = 0;

  Future<void> downloadNow() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final id = await FlutterDownloader.enqueue(
              url:
                  'https://firebasestorage.googleapis.com/v0/b/new1-86df6.appspot.com/o/2023-05-02%2019%3A26%3A35.846859.apk?alt=media&token=27aee476-e679-4c3c-bd7a-466e98aa7745',
              savedDir: '/storage/emulated/0/Download',
              fileName: '${widget.walpaperId}.jpg')
          .then((value) {
        getDownloadsCount();
        final firestore =
            FirebaseFirestore.instance.collection('downloadsCount');
        final userDoc = firestore.doc(widget.walpaperId);
        userDoc.get().then((snapshot) async {
          if (snapshot.exists) {
            await userDoc.update({'count': noOfDownloads + 1});
          } else {
            userDoc.set({'count': 1});
          }
        }).onError((error, stackTrace) {});
        Utils().toastMessage(errorMsg: 'Downloaded', bgColor: Colors.green);
      });
    } else {
      //print('no permission');
    }
  }

  Future<int> getDownloadsCount() async {
    int counts;
    final firestore = FirebaseFirestore.instance;
    final snapshot =
        await firestore.doc('downloadsCount/${widget.walpaperId}').get();
    final data = snapshot.data();
    //print(data!['count']);
    noOfDownloads = data!['count'];
    counts = noOfDownloads;
    return counts;
  }

  ReceivePort receiveport = ReceivePort();
  int progress = 0;
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        receiveport.sendPort, "DownloadingVideo");

    receiveport.listen((message) {
      setState(() {
        progress = message;
      });
    });

    FlutterDownloader.registerCallback(downloadCallBack);
    super.initState();
  }

  static downloadCallBack(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName('DownloadingVideo');
    sendPort?.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SingleWallpaperProvider>(context);
    provider.checkFavorite(widget.walpaperId);
    final uid = auth.currentUser?.uid;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
                image: NetworkImage(
                  widget.walpaperUrl,
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  navButton(
                    const Icon(Icons.arrow_back_ios_new),
                    () => Navigator.pop(context),
                  ),
                  // TooltipWithCloseButton(
                  //   message: "Heelow Wolrd",
                  // ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // statisticIcon(
                          //     icon: const Icon(
                          //       Icons.thumb_up,
                          //       color: Colors.white,
                          //       size: 30,
                          //     ),
                          //     statistic: 15.5,
                          //     onPress: () {}),
                          // const SizedBox(
                          //   height: 30,
                          // ),
                          statisticIcon(
                              icon: provider.isFavt
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                              //statistic: 15.5,
                              onPress: () {
                                provider.makeFavourite(context,
                                    widget.walpaperUrl, widget.walpaperId);
                              }),
                          const SizedBox(
                            height: 10,
                          ),

                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  downloadNow();
                                },
                                icon: Icon(
                                  Icons.file_download,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              FutureBuilder<int>(
                                  future: getDownloadsCount(),
                                  builder: (context, snapshot) {
                                    print(snapshot);
                                    if (snapshot.hasData) {
                                      return Text(
                                        progress.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      );
                                    } else {
                                      return Text(
                                        '0',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      );
                                    }
                                  })
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      provider.showBottomSheet(context, widget.walpaperUrl);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      width: MediaQuery.of(context).size.width * 0.80,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Set Wallpaper',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget statisticIcon(
    {required Icon icon, double? statistic, required Function onPress}) {
  return Column(
    children: [
      IconButton(
          onPressed: () {
            onPress();
          },
          icon: icon),
      Text(
        statistic == null ? ' ' : '$statistic k',
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      )
    ],
  );
}
