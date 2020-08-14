import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sneakershootnews/controllers/news_controller.dart';
import 'package:sneakershootnews/models/news.dart';

import 'news_detail_screen.dart';

NewsController _controller = NewsController();
class NewsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF5F5F5),
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      body: Column(
        children: <Widget>[
          FetchingNews()
        ],
      ),
    );
  }
}

class ListOfNews extends StatefulWidget {
  final List<News> newsList;
  ListOfNews({this.newsList});

  @override
  _ListOfNewsState createState() => _ListOfNewsState();
}

class _ListOfNewsState extends State<ListOfNews> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => NewsDetail(
                      imageURL: '${widget.newsList[index].url}',
                    )
                ));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  margin: EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            imageUrl: '${widget.newsList[index].urlToImage}',
                            fit: BoxFit.cover,
                          )

                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('${widget.newsList[index].title}',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${widget.newsList[index].description}',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  )),
            );
          },
          itemCount: widget.newsList.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

class FetchingNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
      future: _controller.fetchNews(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Expanded(child: Center(child: CircularProgressIndicator()));
          default:
            if (snapshot.hasError)
              return Expanded(
                  child: Center(child: CircularProgressIndicator()));
            else
              return Container(
                child: ListOfNews(
                  newsList: snapshot.data,
                ),
              );

        //
        }
      },
    );
  }
}
