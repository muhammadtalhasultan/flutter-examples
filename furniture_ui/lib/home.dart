import 'package:flutter/material.dart';
import 'package:furniture_ui/data.dart';

import 'icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Widget _buildGradientContainer(double width, double height) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: width * .8,
        height: height / 2,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFfbfcfd), Color(0xFFf2f3f8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1.0])),
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 40.0,
      left: 20.0,
      right: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(CustomIcons.menu, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(CustomIcons.search, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildTitle(double height) {
    return Positioned(
      top: height * .15,
      left: 30.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Wooden Armchair",
              style: TextStyle(fontSize: 28.0, fontFamily: "Montserrat-Bold")),
          Text("Lorem Ipsem",
              style: TextStyle(fontSize: 16.0, fontFamily: "Montserrat-Medium"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f3f8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildGradientContainer(width, height),
              _buildAppBar(),
              _buildTitle(height),
              SizedBox(height: height * .9),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: height * .6,
                  child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 35.0, bottom: 60.0),
                        child: SizedBox(
                          width: 200.0,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 45.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: (index % 2 == 0)
                                          ? Colors.white
                                          : const Color(0xFF2a2d3f),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(0.0, 10.0),
                                            blurRadius: 10.0)
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      images[index],
                                      width: 172.5,
                                      height: 199.0,
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(title[index],
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: "Montserrat-Bold",
                                                  color: (index % 2 == 0)
                                                      ? const Color(0xFF2a2d3f)
                                                      : Colors.white)),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text("NEW SELL",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontFamily:
                                                      "Montserrat-Medium",
                                                  color: (index % 2 == 0)
                                                      ? const Color(0xFF2a2d3f)
                                                      : Colors.white)),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(price[index] + " \$",
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontFamily: "Montserrat-Bold",
                                                  color: (index % 2 == 0)
                                                      ? const Color(0xFF2a2d3f)
                                                      : Colors.white))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.panorama_horizontal),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.bookmark_border),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 65.0,
        height: 65.0,
        decoration: BoxDecoration(
            color: const Color(0xFFfa7b58),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFFf78a6c).withOpacity(.6),
                  offset: const Offset(0.0, 10.0),
                  blurRadius: 10.0)
            ]),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 35.0,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
