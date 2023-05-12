import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Providers/intro_screen_provider.dart';
import 'package:walpy_wallpapers/Screens/main_activity_screen.dart';
import 'package:walpy_wallpapers/Screens/select_auth_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});
  static const pageName = '/introScreen';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IntroScreenProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: PageView.builder(
                itemCount: 3,
                onPageChanged: (value) {
                  provider.changeCurrentIndex(value);
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage(provider.introData[index].imageUrl),
                          width: MediaQuery.of(context).size.width * 0.70,
                        ),
                        Text(
                          provider.introData[index].title,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          provider.introData[index].subtitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          DotBuilder(provider.currentIndex),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, SelectAuthentication.pageName);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondary,
              ),
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
              width: MediaQuery.of(context).size.width,
              child: const Text('Get Started'),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DotBuilder extends StatelessWidget {
  int currentIndex;
  DotBuilder(
    this.currentIndex, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.all(5),
          height: 10,
          width: currentIndex == index ? 30 : 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
