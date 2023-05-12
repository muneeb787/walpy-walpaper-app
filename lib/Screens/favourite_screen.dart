import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:walpy_wallpapers/Models/walpaper_data_model.dart';
import 'package:walpy_wallpapers/Screens/single_walpaper_view.dart';
import 'package:walpy_wallpapers/Services/api_services.dart';
import 'package:walpy_wallpapers/Widgets/nav_button.dart';

class FavouriteScreen extends StatefulWidget {
  static const pageName = '/favouritescreen';

  FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser?.uid;
    final api = ApiServices();

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navButton(
                    const Icon(Icons.arrow_back_ios_new),
                    () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Favourites'),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<WalpaperModel>>(
                    future: api.getWallpapersById(user!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: LoadingAnimationWidget.flickr(
                              leftDotColor: Colors.black45,
                              rightDotColor: Colors.red,
                              size: 20),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Center(
                              child: Column(
                            children: [
                              const Icon(Icons.error),
                              const Text('No Internet Connection')
                            ],
                          )),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No data found.'),
                        );
                      } else {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 2 / 4,
                          ),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SingleWalpaperScreen(
                                      snapshot.data![index].imageUrl,
                                      snapshot.data![index].id);
                                }));
                              },
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data![index].imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    LoadingAnimationWidget.flickr(
                                        leftDotColor: Colors.black45,
                                        rightDotColor: Colors.red,
                                        size: 20),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
