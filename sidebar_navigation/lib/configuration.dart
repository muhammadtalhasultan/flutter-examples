import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = const Color(0xff181638);
List<BoxShadow> shadowList = [
  BoxShadow(
      color: Colors.grey.shade300, blurRadius: 30, offset: const Offset(0, 10))
];

List<Map> categories = [
  {
    'name': 'Cats',
    'iconPath': 'assets/images/cat.png',
  },
  {
    'name': 'Dogs',
    'iconPath': 'assets/images/dog.png',
  },
  {
    'name': 'Bunnies',
    'iconPath': 'assets/images/rabbit.png',
  },
  {
    'name': 'Parrots',
    'iconPath': 'assets/images/parrot.png',
  },
  {
    'name': 'Horses',
    'iconPath': 'assets/images/horse.png',
  }
];

List<Map> drawerItems = [
  {'icon': FontAwesomeIcons.paw, 'title': 'Adoption'},
  {'icon': Icons.mail, 'title': 'Donation'},
  {'icon': FontAwesomeIcons.plus, 'title': 'Add pet'},
  {'icon': Icons.favorite, 'title': 'Favorites'},
  {'icon': Icons.mail, 'title': 'Messages'},
  {'icon': FontAwesomeIcons.userAlt, 'title': 'Profile'},
];
