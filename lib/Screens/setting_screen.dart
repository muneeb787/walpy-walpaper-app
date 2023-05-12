import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Widgets/nav_button.dart';

import '../Widgets/custom_list_tile.dart';
import 'profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const pageName = '/settingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              navButton(
                const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                () => Navigator.pop(context),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Settings'),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProfileScreen();
                  }));
                },
                child: customListTile(
                    itemIcon: Icons.manage_accounts,
                    itemTitle: 'Update Profile',
                    trailing: true),
              ),
              customListTile(
                itemIcon: Icons.star_border,
                itemTitle: 'Rate this App',
              ),
              customListTile(
                itemIcon: Icons.share,
                itemTitle: 'Share with Friends',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
