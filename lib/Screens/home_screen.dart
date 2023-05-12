import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Models/walpaper_data_model.dart';
import 'package:walpy_wallpapers/Providers/home_screen_provider.dart';
import 'package:walpy_wallpapers/Screens/single_walpaper_view.dart';
import 'package:walpy_wallpapers/Services/api_services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context, listen: false);
    final api = ApiServices();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured',
                  style: GoogleFonts.ebGaramond(
                      textStyle: Theme.of(context).textTheme.bodyLarge),
                ),
                // Consumer<HomeScreenProvider>(
                //   builder: ((context, value, child) {
                //     return Row(
                //       children: [
                //         IconButton(
                //           onPressed: value.currentIndex > 0
                //               ? () {
                //                   value.deccIndex();
                //                 }
                //               : () {},
                //           icon: Icon(
                //             Icons.arrow_back_outlined,
                //             color: value.currentIndex > 0
                //                 ? Colors.white
                //                 : Colors.grey,
                //           ),
                //         ),
                //         IconButton(
                //           onPressed: () {
                //             value.incIndex();
                //           },
                //           icon: const Icon(
                //             Icons.arrow_forward_outlined,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ],
                //     );
                //   }),
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<WalpaperModel>>(
              future: api.getTraditionalWallpapers(1, 'latest'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      CarouselSlider.builder(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.97,
                            // aspectRatio: 2,
                            //initialPage: 2,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    snapshot.data![itemIndex].imageUrl,
                                  ),
                                ),
                              ),
                            );
                          }),
                      // Container(
                      //   height: 200,
                      //   width: double.infinity,
                      //   child: InfiniteCarousel.builder(
                      //     itemCount: snapshot.data!.length,
                      //     itemExtent: MediaQuery.of(context).size.width,
                      //     center: true,
                      //     anchor: 1,
                      //     velocityFactor: 0.1,
                      //     onIndexChanged: (index) {},
                      //     axisDirection: Axis.horizontal,
                      //     loop: true,
                      //     itemBuilder: (context, itemIndex, realIndex) {
                      //       return
                      //     },
                      //   ),
                      // ),
                      // Consumer<HomeScreenProvider>(
                      //   builder: (context, value, child) {
                      //     return InkWell(
                      //       onTap: () {
                      //         Navigator.push(context,
                      //             MaterialPageRoute(builder: (context) {
                      //           return SingleWalpaperScreen(
                      //               snapshot.data![value.currentIndex].imageUrl,
                      //               snapshot.data![value.currentIndex].id);
                      //         }));
                      //       },
                      //       child: Container(
                      //         height: 180,
                      //         width: double.infinity,
                      //         decoration: BoxDecoration(
                      //           color: Theme.of(context)
                      //               .colorScheme
                      //               .secondary
                      //               .withOpacity(0.1),
                      //           borderRadius: BorderRadius.circular(20),
                      //           image: DecorationImage(
                      //             fit: BoxFit.cover,
                      //             image: NetworkImage(
                      //               snapshot.data![value.currentIndex].imageUrl,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        child: InkWell(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
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
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  width: 110,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data![index].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Icon(
                      Icons.broken_image,
                    ),
                  );
                } else {
                  return Center(
                    child: LoadingAnimationWidget.flickr(
                        leftDotColor: Colors.black45,
                        rightDotColor: Colors.red,
                        size: 20),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Trending',
                  style: GoogleFonts.ebGaramond(
                      textStyle: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: api.getTraditionalWallpapers(1, 'oldest'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      crossAxisCount: 2,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SingleWalpaperScreen(
                                  snapshot.data![index].imageUrl,
                                  snapshot.data![index].id);
                            }));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image: NetworkImage(
                                  snapshot.data![index].imageUrl,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Icon(
                        Icons.broken_image,
                      ),
                    );
                  }
                  //else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //   return const Center(
                  //     child: Text('No data found.'),
                  //   );
                  // }
                  else {
                    return Center(
                      child: LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.black45,
                          rightDotColor: Colors.red,
                          size: 20),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
