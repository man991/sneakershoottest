import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NewsDetail extends StatefulWidget {
  static final String id = 'News Detail';
  final String imageURL;
  NewsDetail({this.imageURL});
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF5F5F5),
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),

      body: Column(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 80,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                        iconSize: 25.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'News',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: WebView(
                initialUrl: widget.imageURL,
//                gestureRecognizers: Set()
//                ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
//                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: ((WebViewController webViewController){
                  _completer.complete(webViewController);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
