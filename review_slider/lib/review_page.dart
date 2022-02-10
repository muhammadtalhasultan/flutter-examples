import 'package:flutter/material.dart';

import 'arc.dart';
import 'custom_painter.dart';

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({Key? key}) : super(key: key);

  @override
  _MyReviewPageState createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage>
    with TickerProviderStateMixin {
  final PageController pageControl = PageController(
    initialPage: 2,
    keepPage: false,
    viewportFraction: 0.2,
  );

  int slideValue = 200;
  int lastAnimPosition = 2;

  late AnimationController animation;

  List<ArcItem> arcItems = [];

  late ArcItem badArcItem;
  late ArcItem ughArcItem;
  late ArcItem okArcItem;
  late ArcItem goodArcItem;

  late Color startColor;
  late Color endColor;

  @override
  void initState() {
    super.initState();

    badArcItem =
        ArcItem("POOR", const [Color(0xFFfe0944), Color(0xFFfeae96)], 0.0);
    ughArcItem =
        ArcItem("BAD", const [Color(0xFFF9D976), Color(0xfff39f86)], 0.0);
    okArcItem =
        ArcItem("OK", const [Color(0xFF21e1fa), Color(0xff3bb8fd)], 0.0);
    goodArcItem =
        ArcItem("GOOD", const [Color(0xFF3ee98a), Color(0xFF41f7c7)], 0.0);

    arcItems.add(badArcItem);
    arcItems.add(ughArcItem);
    arcItems.add(okArcItem);
    arcItems.add(goodArcItem);

    startColor = const Color(0xFF21e1fa);
    endColor = const Color(0xff3bb8fd);

    animation = AnimationController(
      value: 0.0,
      lowerBound: 0.0,
      upperBound: 400.0,
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener(() {
        setState(() {
          slideValue = animation.value.toInt();

          double ratio;

          if (slideValue <= 100) {
            ratio = animation.value / 100;
            startColor =
                Color.lerp(badArcItem.colors[0], ughArcItem.colors[0], ratio)!;
            endColor =
                Color.lerp(badArcItem.colors[1], ughArcItem.colors[1], ratio)!;
          } else if (slideValue <= 200) {
            ratio = (animation.value - 100) / 100;
            startColor =
                Color.lerp(ughArcItem.colors[0], okArcItem.colors[0], ratio)!;
            endColor =
                Color.lerp(ughArcItem.colors[1], okArcItem.colors[1], ratio)!;
          } else if (slideValue <= 300) {
            ratio = (animation.value - 200) / 100;
            startColor =
                Color.lerp(okArcItem.colors[0], goodArcItem.colors[0], ratio)!;
            endColor =
                Color.lerp(okArcItem.colors[1], goodArcItem.colors[1], ratio)!;
          } else if (slideValue <= 400) {
            ratio = (animation.value - 300) / 100;
            startColor =
                Color.lerp(goodArcItem.colors[0], badArcItem.colors[0], ratio)!;
            endColor =
                Color.lerp(goodArcItem.colors[1], badArcItem.colors[1], ratio)!;
          }
        });
      });

    animation.animateTo(slideValue.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
        color: Colors.white, fontSize: 24.00, fontWeight: FontWeight.bold);

    return Container(
      margin: MediaQuery.of(context).padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "How was your experience\nwith us?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                (MediaQuery.of(context).size.width / 2) + 60),
            painter: SmilePainter(slideValue),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              ArcChooser()
                ..arcSelectedCallback = (int pos, ArcItem item) {
                  int animPosition = pos - 2;
                  if (animPosition > 3) {
                    animPosition = animPosition - 4;
                  }

                  if (animPosition < 0) {
                    animPosition = 4 + animPosition;
                  }

                  if (lastAnimPosition == 3 && animPosition == 0) {
                    animation.animateTo(4 * 100.0);
                  } else if (lastAnimPosition == 0 && animPosition == 3) {
                    animation.forward(from: 4 * 100.0);
                    animation.animateTo(animPosition * 100.0);
                  } else if (lastAnimPosition == 0 && animPosition == 1) {
                    animation.forward(from: 0.0);
                    animation.animateTo(animPosition * 100.0);
                  } else {
                    animation.animateTo(animPosition * 100.0);
                  }

                  lastAnimPosition = animPosition;
                },
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Container(
              width: 150.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [startColor, endColor]),
                borderRadius: BorderRadius.circular(25.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'SUBMIT',
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
