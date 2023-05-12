import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Screens/favourite_screen.dart';
import '../Providers/get_user_data_provider.dart';
import '../Providers/logout_provider.dart';
import '../Screens/priacy_policy_screen.dart';
import 'custom_list_tile.dart';
import 'nav_button.dart';

class customDrawer extends StatelessWidget {
  const customDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LogoutProvider>(context);
    final provider1 = Provider.of<GetProfileProvider>(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8E69F7),
              Color(0xFFB11AAB),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: navButton(
                        const Icon(Icons.close),
                        () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black12),
                      child: ClipRRect(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: provider1.photoUrl(),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Text(
                        provider1.dispalyName(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    //Navigator.pushNamed(context, MainActivity.pageName);
                    Navigator.pop(context);
                  },
                  child: customListTile(
                    itemIcon: Icons.home_outlined,
                    itemTitle: 'Home',
                  ),
                ),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, FavouriteScreen.pageName),
                  child: customListTile(
                    itemIcon: Icons.favorite_border_outlined,
                    itemTitle: 'Favourites',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PrivacyPolicyScreen.pageName);
                  },
                  child: customListTile(
                    itemIcon: Icons.privacy_tip_outlined,
                    itemTitle: 'Privacy Policy',
                  ),
                ),
                // customListTile(
                //   itemIcon: Icons.report_problem_outlined,
                //   itemTitle: 'Report a Problem',
                // ),
              ],
            ),
            InkWell(
                onTap: () {
                  provider.logoutUser(context);
                },
                child: customListTile(
                    itemIcon: Icons.logout, itemTitle: 'Sign Out'))
          ],
        ),
      ),
    );
  }
}
