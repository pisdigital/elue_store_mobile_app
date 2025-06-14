class SearchResponseModel {
  final int id;
  final String title;
  final String thumbnail;

  SearchResponseModel({
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  // Factory constructor to create an instance from JSON
  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
    );
  }

  // Method to convert the object back to JSON, if needed
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
    };
  }
}
