import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Screens/search_screen.dart';

import '../Providers/bottom_nav_bar_provider.dart';
import '../Screens/setting_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavBarProvider>(context);
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15)),
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Ink(
            width: 40,
            height: 40,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                provider.changeCurrentIndex(0);
              },
              child: SizedBox(
                child: SvgPicture.asset(
                  provider.currentIndex == 0
                      ? 'assets/icons/home_selected.svg'
                      : 'assets/icons/home.svg',
                  height: 25.0,
                  width: 25.0,
                  fit: BoxFit.scaleDown,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ),
          Ink(
            width: 40,
            height: 40,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                provider.changeCurrentIndex(1);
              },
              child: SizedBox(
                child: SvgPicture.asset(
                  provider.currentIndex == 1
                      ? 'assets/icons/category_selected.svg'
                      : 'assets/icons/category.svg',
                  height: 25.0,
                  width: 25.0,
                  fit: BoxFit.scaleDown,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ),
          Ink(
            width: 40,
            height: 40,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pushNamed(context, SearchScreen.pageName);
              },
              child: SizedBox(
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  height: 25.0,
                  width: 25.0,
                  fit: BoxFit.scaleDown,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ),
          Ink(
            width: 40,
            height: 40,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SettingsScreen();
                }));
              },
              child: SizedBox(
                child: SvgPicture.asset(
                  'assets/icons/setting.svg',
                  height: 25.0,
                  width: 25.0,
                  fit: BoxFit.scaleDown,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
