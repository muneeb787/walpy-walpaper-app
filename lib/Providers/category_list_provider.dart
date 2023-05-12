import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import '../Models/category_list_model.dart';

class CategoryPhotoProvider with ChangeNotifier {
  List<CategoryModel> categoryData = [
    CategoryModel(title: 'Nature', url: 'assets/images/Nature.png'),
    CategoryModel(title: 'Abstract', url: 'assets/images/Abstract.png'),
    CategoryModel(title: 'Colorful', url: 'assets/images/Colorful.png'),
    CategoryModel(title: 'Animals', url: 'assets/images/Animals.png'),
    CategoryModel(title: 'Architecture', url: 'assets/images/Architecture.png'),
    CategoryModel(title: 'Texture', url: 'assets/images/Texture.png'),
  ];

  List<WallpaperManager> categoryPhotos = [];
  final bool _isLoading = true;
  get isLoading => _isLoading;

  // GetSearchedWallpapers(String query) async {
  //   categoryPhotos = [];
  //   for (int i = 0; i < 1; i++) {
  //     categoryPhotos = await ApiServices.getSearchedPhotos(i,query);
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }

  // String getSearchedPhotos(int index){
  //   return categoryPhotos[index].urls;
  // }
}
