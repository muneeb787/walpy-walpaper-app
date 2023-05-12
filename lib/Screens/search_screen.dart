import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Providers/search_activity_provider.dart';
import 'package:walpy_wallpapers/Screens/single_walpaper_view.dart';
import 'package:walpy_wallpapers/Widgets/nav_button.dart';

import '../Models/walpaper_data_model.dart';
import '../Services/api_services.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  static const pageName = '/searchScreen';

  final searchBar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final api = ApiServices();
    final provider = Provider.of<SearchActivityProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search',
                style: GoogleFonts.ebGaramond(
                    textStyle: Theme.of(context).textTheme.bodyLarge),
              ),
              navButton(const Icon(Icons.close), () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Searching through hundreds of photos will be so much easier now.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: searchBar,
            onChanged: (value) {
              provider.setSearchTitle(value.toString());
            },
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            decoration: const InputDecoration(
                fillColor: Color(0xFF3d424c),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                hintStyle: TextStyle(
                  color: Colors.white,
                  //fontSize: 22,
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder<List<WalpaperModel>>(
              future: api.getSearchedWallpapers(1, provider.searchTitle),
              builder: (context, snapshot) {
                print('snapshot: ${snapshot.data}');
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    children: [
                      Image.asset('assets/images/notFound.png'),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'No Search Result Found !',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasData) {
                  return GridView.builder(
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
                          FocusScope.of(context).unfocus();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SingleWalpaperScreen(
                                snapshot.data![index].imageUrl,
                                snapshot.data![index].id);
                          }));
                        },
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data![index].imageUrl,
                          imageBuilder: (context, imageProvider) => Container(

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
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     StatisticIcon(icon: Icons.thumb_up, statistic: 15.5),
                            //     SizedBox(height: 10,),
                            //     StatisticIcon(icon: Icons.favorite, statistic: 15.5),
                            //     SizedBox(height: 10,),
                            //     StatisticIcon(icon: Icons.file_download_outlined, statistic: 15.5),
                            //   ],
                            // ),
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
                } else if (snapshot.hasError) {
                  return Center(
                    child: Center(
                        child: Column(
                      children: const [
                        Icon(Icons.error),
                        Text('No Internet Connection')
                      ],
                    )),
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
          ),
        ]),
      )),
    );
  }
}
