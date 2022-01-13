import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html';

class Details extends StatelessWidget {
  final int id;

  const Details({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: Provider.of<CardModel>(context).cardList[id]['title'],
                  child: SizedBox(
                    height: 400,
                    child: OverflowBox(
                      minWidth: 0,
                      minHeight: 0,
                      maxWidth: double.infinity,
                      child: Image.network(
                        Provider.of<CardModel>(context).cardList[id]
                            ['image_url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    Provider.of<CardModel>(context).cardList[id]['title'],
                    style: const TextStyle(fontSize: 36),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.close_outlined,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                IconRow(
                    url_github: Provider.of<CardModel>(context).cardList[id]
                        ['url_github'],
                    url_host: Provider.of<CardModel>(context).cardList[id]
                        ['url_host']),
                Text(
                  Provider.of<CardModel>(context).cardList[id]['description'],
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  RowItem({Key? key, required this.icon, required this.text}) : super(key: key);

  final FaIcon icon;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          icon,
          text,
        ],
      ),
    );
  }
}

class IconRow extends StatelessWidget {
  IconRow({
    Key? key,
    this.url_host,
    this.url_github,
  });

  final url_host;
  final url_github;

  List<Widget> IconList = [];

  @override
  Widget build(BuildContext context) {
    if (url_host != null) {
      IconList.add(InkWell(
        onTap: () {
          window.open(url_host, 'new tab');
        },
        child: RowItem(
          icon: const FaIcon(FontAwesomeIcons.externalLinkAlt,
              color: Colors.grey),
          text: const Text('Hosted link',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      ));
    }
    if (url_github != null) {
      IconList.add(InkWell(
        onTap: () {
          window.open(url_github, 'new tab');
        },
        child: RowItem(
          icon: const FaIcon(FontAwesomeIcons.github, color: Colors.grey),
          text: const Text('Github link',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      ));
    }

    return Theme(
      data: ThemeData(
          primaryColor: Colors.grey,
          textTheme: const TextTheme(
            bodyText2: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: IconList,
      ),
    );
  }
}
