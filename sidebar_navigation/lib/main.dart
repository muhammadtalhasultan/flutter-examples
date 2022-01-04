import 'package:flutter/material.dart';

import 'drawer_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: const HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Circular'),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
