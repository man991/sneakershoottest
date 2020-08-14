import 'network_helper.dart';

class NewsService{

  Future<dynamic> getListNews() async{
    var url = 'http://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=d8a07303998b431c8fa485c0288a5928';
    NetworkHelper networkHelper = NetworkHelper(url);
    var listNews = await networkHelper.getRawData();
    return listNews;
  }

}

