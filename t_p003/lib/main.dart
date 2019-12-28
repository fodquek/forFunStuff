import 'package:flutter/material.dart';
import 'dart:math';

var rng = new Random();

final List<Color> rngColorCave = [
  Colors.black,
  Colors.purple,
  Colors.deepPurple,
  Colors.blue,
  Colors.cyan,
  Colors.greenAccent,
  Colors.lightGreen,
  Colors.green,
  Colors.yellowAccent,
  Colors.yellow,
  Colors.orangeAccent,
  Colors.orange,
  Colors.deepOrangeAccent,
  Colors.deepOrange,
  Colors.redAccent,
  Colors.red,
  Colors.white,
];

Color randomColor() => rngColorCave[rng.nextInt(rngColorCave.length)];
double makeFontSize(double w, double h) => w > h ? h / 20 : w / 20;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NoNSerious Calculator",
      home: HomeWidget(key),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget(Key key) : super(key: key);
  ArtOfState createState() => ArtOfState();
}

class ArtOfState extends State<HomeWidget> {

  final int upperLimit = 16;
  bool nonNegative = true;
  String leftOperand = "0";
  String rightOperand = "0";

  void signBoxSwitchero(){
    setState(() {
      nonNegative = !nonNegative;
    });
  }

  void push(String value) {
    setState(() {
      if(rightOperand == "0") {
        rightOperand = value;
      }
      else if(rightOperand.length < upperLimit) {
        rightOperand += value;
      }
    });
  }

  void pop() {
    setState(() {
      if(rightOperand.length >= 1) {
        rightOperand = rightOperand.substring(0, rightOperand.length - 1);
        if(rightOperand.length < 1) {
          rightOperand = "0";
        }
      }
      else {
        rightOperand = "0";
      }
    });
  }

  void operation(String op) {
    setState(() {

      if(!rightOperand.contains(".") && op == ".") {
        push(".");
        return;
      }
      else if(op == "<<<") {
        pop();
        return;
      }
      double left = double.parse(leftOperand);
      double right = double.parse(rightOperand);
      right *= nonNegative ? 1.0 : -1.0;
      switch (op) {
        case "+":
          left += right;
          break;
        case "-":
          left -= right;
          break;
        case "x":
          left *= right;
          break;
        case "/":
          left /= right;
          break;
        default:
        }
        if(!left.isNaN) {
          leftOperand = left.toString();
          rightOperand = "0";
          //push(left.toString());
        }
    });
  }

  @override
  Widget build(BuildContext context){

    final double ratio = 0.9;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double signBoxWidth = screenWidth * 0.15 * ratio;
    final double signBoxHeight = screenHeight * 0.3 * 0.5 * ratio;
    final double rightOperandWidth = screenWidth * 0.85 * ratio;
    final double rightOperandHeight = screenHeight * 0.3 * 0.5 * ratio;
    final double leftOperandWidth = screenWidth * ratio;
    final double leftOperandHeight = screenHeight * 0.3 * 0.5 * ratio;
    final double downtownWidth = screenWidth * ratio;
    final double downtownHeight = screenHeight * 0.7 * ratio;
    final double buttonWidth = downtownWidth * 0.25 * ratio;
    final double buttonHeight = downtownHeight * 0.25 * ratio;

    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    CoolerButton(
                      nonNegative ? "+" : "-",
                      signBoxWidth,
                      signBoxHeight,
                      signBoxSwitchero
                    ),

                    Container(
                      width: rightOperandWidth,
                      height:  rightOperandHeight,
                      color: randomColor(),
                      child: CoolerText(
                          rightOperand,
                          26,
                        ),
                    ),
                  ],
                ),
                Container(
                  width: leftOperandWidth,  
                  height: leftOperandHeight,
                  color: randomColor(),
                  child: CoolerText(
                          leftOperand,
                          26,
                        ),
                ),
              ],
            ),// upperTown
            Container(
              width: downtownWidth,
              height: downtownHeight,
              color: randomColor(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CoolerButton(
                        "7",
                        buttonWidth,
                        buttonHeight,
                        () => push("7")
                      ),
                      CoolerButton(
                        "8",
                        buttonWidth,
                        buttonHeight,
                        () => push("8")
                      ),
                      CoolerButton(
                        "9",
                        buttonWidth,
                        buttonHeight,
                        () => push("9")
                      ),
                      CoolerButton(
                        "+",
                        buttonWidth,
                        buttonHeight,
                        () => operation("+")
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CoolerButton(
                        "4",
                        buttonWidth,
                        buttonHeight,
                        () => push("4")
                      ),
                      CoolerButton(
                        "5",
                        buttonWidth,
                        buttonHeight,
                        () => push("5")
                      ),
                      CoolerButton(
                        "6",
                        buttonWidth,
                        buttonHeight,
                        () => push("6")
                      ),
                      CoolerButton(
                        "-",
                        buttonWidth,
                        buttonHeight,
                        () => operation("-")
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CoolerButton(
                        "1",
                        buttonWidth,
                        buttonHeight,
                        () => push("1")
                      ),
                      CoolerButton(
                        "2",
                        buttonWidth,
                        buttonHeight,
                        () => push("2")
                      ),
                      CoolerButton(
                        "3",
                        buttonWidth,
                        buttonHeight,
                        () => push("3")
                      ),
                      CoolerButton(
                        "x",
                        buttonWidth,
                        buttonHeight,
                        () => operation("x")
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CoolerButton(
                        "0",
                        buttonWidth,
                        buttonHeight,
                        () => push("0")
                      ),
                      CoolerButton(
                        ".",
                        buttonWidth,
                        buttonHeight,
                        () => operation(".")
                      ),

                      CoolerButton(
                        "🐸",
                        buttonWidth,
                        buttonHeight,
                        () => operation("<<<")
                      ),

                      CoolerButton(
                        "/",
                        buttonWidth,
                        buttonHeight,
                        () => operation("/")
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class CoolerText extends StatelessWidget {
  const CoolerText(this._data, this._fontSize);
  final String _data;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          _data,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.bold,
            color: randomColor(),
          ),
        ),
      ),
    );
  }
}

class CoolerButton extends StatelessWidget {

  final String _data;
  final double _width;
  final double _height;
  final Function _fn;

  CoolerButton(this._data, this._width, this._height, this._fn);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      color: randomColor(),
      child: MaterialButton(
        onPressed: _fn,
        child: CoolerText(
          _data,
          _width < _height ? _height / 3.5 : _width / 3.5,
        ),
      ),
    );
  }
}