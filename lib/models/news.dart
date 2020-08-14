class News{
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  News({this.title, this.description, this.urlToImage, this.url});

  factory News.fromJson(Map<String, dynamic> json){
    return News(
      title: json["title"] as String,
      description: json["description"] as String,
      urlToImage: json["urlToImage"] as String,
      url: json["url"] as String,
    );
  }
}
