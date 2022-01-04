import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'configuration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen = true;
                            });
                          }),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryGreen,
                      ),
                      const Text(
                        'Pakistan',
                        style: TextStyle(
                            color: Color(0xff416d6d),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWVufGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.search),
                  Text('Search anything'),
                  Icon(Icons.filter_list),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          categories[index]['iconPath'],
                          height: 50,
                          width: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(categories[index]['name'])
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 240,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[300],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: shadowList,
                          ),
                          margin: const EdgeInsets.only(top: 50),
                        ),
                        Align(
                          child: Hero(
                              tag: 1,
                              child: Image.asset('assets/images/pet-cat2.png')),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadowList,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ))
                ],
              ),
            ),
            Container(
              height: 240,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: shadowList,
                          ),
                          margin: const EdgeInsets.only(top: 50),
                        ),
                        Align(
                          child: Image.asset('assets/images/pet-cat1.png'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadowList,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
