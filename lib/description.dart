import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:html';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  // String markdownText = 'Markdown';

  // fetchFileData() async {
  //   String response;
  //   response = await rootBundle.loadString('assets/description.md');
  //   setState(() {
  //     markdownText = response;
  //   });
  // }

  // @override
  // void initState() {
  //   fetchFileData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //Future<String> loadAsset(BuildContext context) async  {
    //  return await DefaultAssetBundle.of(context).loadString('assets/description.md');
    //}
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Stack(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.only(top: 20.0),
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.only(top: 55.0),
              height: 300,
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Marek Zakrzewski',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .apply(color: Colors.black),
                        ),
                      ),
                      Text('Developer',
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text(
                      'Contact me at\nm.zakrzwsk@gmail.com',
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            window.open(
                                'https://www.linkedin.com/in/marek-zakrzewski-38547b145/',
                                'new tab');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const FaIcon(FontAwesomeIcons.linkedin,
                                    size: 32),
                                Text('LinkedIn',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            window.open(
                                'https://github.com/marko-z', 'new tab');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                FaIcon(FontAwesomeIcons.github, size: 32),
                                Text('GitHub'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
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
        ],
      ),
    );
  }
}
