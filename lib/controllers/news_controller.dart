import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sneakershootnews/models/news.dart';
import 'package:sneakershootnews/services/news_service.dart';


class NewsController extends ChangeNotifier{

  NewsService newsService = NewsService();
  List<News> listofNews =[];

  List<News> parseNews(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<News>((json) => News.fromJson(json)).toList();
  }

  Future<List<News>> fetchNews() async {
    Future.delayed(Duration(seconds: 1));
    var response = await  newsService.getListNews();
    var news = json.encode(response["articles"]);
    return parseNews(news);
  }





}