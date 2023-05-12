import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Models/intro_screen_model.dart';

class IntroScreenProvider with ChangeNotifier {
  final List<IntroScreenData> _introData = [
    IntroScreenData(
        imageUrl: 'assets/images/object-1.png',
        title: 'Only wallpaper app !You\'ll need.',
        subtitle:
            'walpy makes finding and using stylish wallpaper easier than ever. It really is the only wallpaper app youneed.'),
    IntroScreenData(
        imageUrl: 'assets/images/object-2.png',
        title: 'Choose from various Collections',
        subtitle:
            'With new Wallpapers added every week, you\'ll be sure to find the perfect paper for your space. Select from our many categories like abstract, animals, plants, world maps and more!'),
    IntroScreenData(
        imageUrl: 'assets/images/object-3.png',
        title: 'You won\'t miss anyupdates, stay notified.',
        subtitle:
            'Searching the internet for wallpapers takes too much time! Walper is the first app of its kind to deliver a curated selection of wallpaper designs hand-picked-you\'ll always find what you\'re looking for an something new every time.'),
  ];

  List get introData => _introData;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeCurrentIndex(newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
