import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:flutter_markdown/flutter_markdown.dart';

class Description extends StatefulWidget {
  const Description({Key? key}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  String markdownText = 'Markdown';

  fetchFileData() async {
    String response;
    response = await rootBundle.loadString('assets/description.md');
    setState(() {
      markdownText = response;
    });
  }

  @override
  void initState() {
    fetchFileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Future<String> loadAsset(BuildContext context) async  {
    //  return await DefaultAssetBundle.of(context).loadString('assets/description.md');
    //}
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Stack(children: <Widget>[
          Card(
            margin: const EdgeInsets.only(top: 50.0),
            elevation: 2,
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(10.0),
              child: Markdown(
                data: markdownText,
              ),
              //style: Theme.of(context).textTheme(subhead),
              //We'll see if this works at what point can the FutureBuilder be
              //used as child?
            ),
          ),
          Positioned(
            //what are these for?
            top: .0,
            left: .0,
            right: .0,
            child: Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey[200], //I hope that's fine
                child: const CircleAvatar(
                  radius: 51,
                  backgroundImage: AssetImage('assets/selfie.jpg'),
                  //it says prefer const with constant constructors =>
                  //AssetImage(...) is a constant constructor?
                ),
              ),
            ),
          ),
        ]));
  }
}
