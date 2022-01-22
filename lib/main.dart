import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:portfolio/details.dart';
import 'package:portfolio/home.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

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

  Future<List<dynamic>> fetchCardListData() async {
    // final String response = await rootBundle.loadString('assets/appcards.json');
    final response = await http.get(
      Uri.parse(
          'https://mz-portfolio-resources.s3.eu-north-1.amazonaws.com/appcards.json'),
    );
    if (response.statusCode == 200) {
      List<dynamic> mapResult = json.decode(response.body)['appcards'];
      return mapResult;
    } else {
      throw Exception('Failed to load');
    }
  }

  CardModel() {
    Future futureData = fetchCardListData();
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: '',
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
