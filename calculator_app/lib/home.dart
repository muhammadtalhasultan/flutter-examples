import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20),
              child: Text(
                result,
                style: const TextStyle(
                    color: Colors.pinkAccent,
                    fontFamily: 'Chivo',
                    fontWeight: FontWeight.w400,
                    fontSize: 70),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 12.5, right: 12.5),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: Colors.grey.shade400.withOpacity(0.5)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                    child: Row(
                      children: <Widget>[
                        Text(equation,
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Chivo')),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          borderRadius: BorderRadius.circular(100.0),
                          onTap: () => {_buttonPressed("×", isClear: true)},
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 45,
                            child: const Text(
                              "×",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: buttons(),
          )
        ],
      ),
    );
  }

  void evaluateEquation() {
    try {
      Expression exp = (Parser()).parse(operatorsMap.entries.fold(
          equation, (prev, elem) => prev.replaceAll(elem.key, elem.value)));

      double res = double.parse(
          exp.evaluate(EvaluationType.REAL, ContextModel()).toString());

      result = double.parse(res.toString()) == int.parse(res.toStringAsFixed(0))
          ? res.toStringAsFixed(0)
          : res.toStringAsFixed(4);
    } catch (e) {
      result = "Error";
    }
  }

  Widget? _buttonPressed(String text, {bool isClear = false}) {
    setState(() {
      if (isClear) {
        equation = result = "0";
      } else if (text == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") equation = result = "0"; // If all empty
      } else {
        if (equation == "0" && text != ".") equation = "";
        equation += text;
      }
      if (!operatorsMap.containsKey(equation.substring(equation.length - 1))) {
        evaluateEquation();
      }
    });
  }

  Widget buttons() {
    return Material(
      color: const Color(0xFFF2F2F2),
      child: GridView.count(
          crossAxisCount: 4, // 4x4 grid
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          children: buttonNames.map<Widget>((e) {
            switch (e) {
              case "+":
                return rbutton(
                  e,
                );
              case "×":
                return rbutton(e);
              case "-":
                return rbutton(e);
              case "÷":
                return rbutton(
                  e,
                );
              default:
                return button(
                  e,
                );
            }
          }).toList()),
    );
  }

  Widget button(
    text,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: Colors.grey.shade300.withOpacity(0.7),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              onTap: () {
                _buttonPressed(text);
              },
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget rbutton(
    text,
  ) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Material(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _buttonPressed(text);
          },
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
