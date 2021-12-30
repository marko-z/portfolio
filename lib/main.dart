import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:portfolio/details.dart';
import 'package:portfolio/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CardModel(),
      child: const MyApp(),
    ),
  );
}

class CardModel extends ChangeNotifier {
  var cardList = [];
  var filteredCardList = [];

  fetchCardListData() async {
    final String response = await rootBundle.loadString('assets/appcards.json');
    final data = await json.decode(response)['appcards'];
    return data;
  }

  CardModel() {
    var futureData = fetchCardListData();
    futureData.then((newData) {
      cardList = List.from(newData);
      filteredCardList = List.from(newData);
      notifyListeners();
    });
  }

  void filter(String query) {
    filteredCardList = List.from(cardList
        .where((el) => el['title'].toLowerCase().contains(query))
        .toList());
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio app',
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.arguments;
        final uri = Uri.parse(settings.name!); //null-safety check
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => Home());
        }
        if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'details') {
          //Could go wrong if no second pathSegment
          final id = int.parse(uri.pathSegments[1]);

          return MaterialPageRoute(
            builder: (context) => Details(id: id),
          );
        }
      },
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
