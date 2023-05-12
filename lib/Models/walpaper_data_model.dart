class WalpaperModel {
  String id;
  String imageUrl;
  String createdDate;

  WalpaperModel(
      {required this.id, required this.imageUrl, required this.createdDate});

  static WalpaperModel fromJson(Map<String, dynamic> json) {
    // print('Walper -------------------------------------------------------------------------');
    // print(json['id']);
    // print(json['urls']['regular']);
    // print(json['created_at']);
    return WalpaperModel(
      id: json['id'],
      imageUrl: json['urls']['regular'],
      createdDate: json['created_at'],
    );
  }
}
