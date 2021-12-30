import 'package:flutter/material.dart';
import 'package:portfolio/description.dart';
import 'package:portfolio/app_card_window.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: const [
                  Description(),
                  AppCardWindow(),
                ],
              ),
            ),
          ),
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tic-tac-toe.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
      ),
    );
  }
}
