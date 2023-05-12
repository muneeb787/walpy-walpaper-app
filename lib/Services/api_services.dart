import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:walpy_wallpapers/Models/walpaper_data_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final firestore = FirebaseFirestore.instance;
  final apiKey = 'iO0EqP9WI8E21_vUUokPhO1E5dU2hX0xsGXpoo0IGsU';
  List<WalpaperModel> traditionalWalpapers = [];
  List<WalpaperModel> searchedWalpapers = [];

  Future<List<WalpaperModel>> getTraditionalWallpapers(
      int page, String orderBY) async {
    final url =
        "https://api.unsplash.com/photos?client_id=$apiKey&page=$page&per_page=20&order_by='$orderBY'";
    final parsedUrl = Uri.parse(url);
    await http.get(parsedUrl).then((responce) {
      final data = jsonDecode(responce.body);
      data.forEach((element) {
        traditionalWalpapers.add(WalpaperModel.fromJson(element));
      });
    });
    return traditionalWalpapers;
  }

  Future<List<WalpaperModel>> getSearchedWallpapers(
      int page, String query) async {
    final url =
        "https://api.unsplash.com/search/photos?client_id=$apiKey&query='$query'&page=$page&per_page=25";
    final parsedUrl = Uri.parse(url);
    await http.get(parsedUrl).then((responce) {
      Map<String, dynamic> jsonData = jsonDecode(responce.body);
      List photos = jsonData['results'];
      photos.forEach((element) {
        searchedWalpapers.add(WalpaperModel.fromJson(element));
      });
    });
    print('ssearched walpaper are: ${searchedWalpapers.length}');
    return searchedWalpapers;
  }

  Future<List<dynamic>> getArrayFromFirestore(
      String documentPath, String arrayName) async {
    final snapshot = await firestore.doc(documentPath).get();
    final data = snapshot.data();

    if (data == null || !data.containsKey(arrayName)) {
      return [];
    }

    final array = data[arrayName];

    if (array is List<dynamic>) {
      return array;
    }

    return [];
  }

  Future<List<WalpaperModel>> getWallpapersById(String uid) async {
    List<WalpaperModel> wallpapersById = [];
    final ids = await getArrayFromFirestore('favourites/$uid', 'favorites');

    for (final id in ids) {
      final url = "https://api.unsplash.com/photos/$id?client_id=$apiKey";
      final parsedUrl = Uri.parse(url);
      final response = await http.get(parsedUrl);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        wallpapersById.add(WalpaperModel.fromJson(jsonData));
      } else {
        throw Exception('Failed to get wallpaper by ID: $id');
      }
    }

    return wallpapersById;
  }
}
