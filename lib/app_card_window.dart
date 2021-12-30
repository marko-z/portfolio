import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:convert';

class AppCardWindow extends StatefulWidget {
  const AppCardWindow({Key? key}) : super(key: key);

  @override
  _AppCardWindowState createState() => _AppCardWindowState();
}

class _AppCardWindowState extends State<AppCardWindow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //const Expanded(child: Spacer()),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'My Apps',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 200,
                child: TextField(
                  onChanged: (text) {
                    Provider.of<CardModel>(context, listen: false).filter(text);
                  },
                  decoration: const InputDecoration(
                    hintText: "Search",
                    // filled: true,
                    // fillColor: Colors.white,
                    //   border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppCardList(),
      ],
    );
  }
}

class AppCardList extends StatelessWidget {
  AppCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
          // padding: const EdgeInsets.all(16),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true, //but this isn't optimal though?
          crossAxisCount: 2,
          children: Provider.of<CardModel>(context).filteredCardList.mapIndexed(
            (index, data) {
              return AnimationConfiguration.staggeredGrid(
                columnCount: 2,
                position: index,
                duration: const Duration(milliseconds: 1000),
                child: ScaleAnimation(
                  // verticalOffset: 50,
                  child: FadeInAnimation(
                    child: AppCard(
                      id: data['id'],
                      title: data['title'],
                      image: data['image'],
                      descriptionShort: data['description_short'],
                    ),
                  ),
                ),
              );
            },
          ).toList()),
    );
  }
}

class AppCard extends StatelessWidget {
  AppCard({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.descriptionShort,
  }) : super(key: key);

  final int id;
  final String title;
  final String image;
  final String descriptionShort;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: SizedBox(
          height: 60,
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(
                      tag: title,
                      child: Container(
                        // as opposed to the regular Image.asset()
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        descriptionShort,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/details/$id',
          );
        });
  }
}
