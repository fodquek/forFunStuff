import 'package:flutter/material.dart';
import 'dart:math';

var rng = new Random();
bool darkMode = false;

final List<List<Color>> rngColorCave = [
  [Colors.blue, Colors.white],
  [Colors.deepPurple, Colors.white],
  [Colors.purple, Colors.white],
  [Colors.green, Colors.white],
  [Colors.deepOrangeAccent, Colors.white],
  [Colors.deepOrange, Colors.white],
  [Colors.redAccent, Colors.white],
  [Colors.red, Colors.white],
  [Colors.white, Colors.black],
  [Colors.cyan, Colors.black],
  [Colors.greenAccent, Colors.black],
  [Colors.lightGreen, Colors.black],
  [Colors.yellowAccent, Colors.black],
  [Colors.yellow, Colors.black],
  [Colors.orangeAccent, Colors.black],
  [Colors.orange, Colors.black],
  [Colors.amber, Colors.black],
  [Colors.black, Colors.white],
];

List<Color> randomColor() => rngColorCave[rng.nextInt(rngColorCave.length)];
double makeFontSize(double w, double h) => w < h ? h / 4.0 : w / 4.0;
//double makeRadius(double w, double h) => w < h ? w / 15.0 : h / 15.0;
double makeRadius(double w, double h) => (w + h) / 2.0; 
Decoration makeDecoration(double w, double h, Color c) => CDB(makeRadius(w, h), c).getProduct();

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

  void flush() {
    setState(() {
      leftOperand = "0";
    });
  }

  void operation(String op) {
    setState(() {

      if(op == ".") {
        if(!rightOperand.contains(".")) {
          push(".");
        }
        return;
      }
      if(op == "<-"){
        pop();
        return;
      }
      if(rightOperand != ".") {
        double left = double.parse(leftOperand);
        if(left == 0.0) {
          leftOperand = rightOperand;
        }
        else {
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
          if(!left.isNaN && !left.isInfinite) {
            leftOperand = left.toString();
          }
        }
        rightOperand = "0";
      }
    });
  }

  @override
  Widget build(BuildContext context){

    final double ratio = 0.9;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double operandFontSize = MediaQuery.of(context).orientation == Orientation.landscape ? 32 : 18;

    final double uptownWidth = screenWidth * ratio;
    final double uptownHeight = screenHeight * 0.3 * ratio;
    final double downtownWidth = screenWidth * ratio;
    final double downtownHeight = screenHeight * 0.7 * ratio;

    final double operandAuxBoxWidth = uptownWidth * 0.15 * ratio;
    final double operandAuxBoxHeight = uptownHeight * 0.5 * ratio;

    final double operandWidth = (uptownWidth - operandAuxBoxWidth);
    final double operandHeight = uptownHeight * 0.5 * ratio;

    final double buttonWidth  = downtownWidth * 0.25 * ratio;
    final double buttonHeight = downtownHeight * 0.25 * ratio;

    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
              width: uptownWidth,
              height: uptownHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CoolerButton(
                          nonNegative ? "+" : "-",
                          operandAuxBoxWidth,
                          operandAuxBoxHeight,
                          randomColor(),
                          signBoxSwitchero,
                        ),
                        Spacer(),
                        Container(
                          width: operandWidth,
                          height:  operandHeight,
                          decoration: makeDecoration(
                            operandWidth,
                            operandHeight,
                            Colors.white,
                          ),
                          child: CoolerText(
                            rightOperand,
                            Colors.black,
                            operandFontSize,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                  Spacer(),
                  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CoolerButton(
                                "C",
                                operandAuxBoxWidth,
                                operandAuxBoxHeight,
                                randomColor(),
                                flush,
                            ),
                            Spacer(),
                            Container(
                              width: operandWidth,  
                              height: operandHeight,
                              decoration: makeDecoration(
                                operandWidth,
                                operandHeight,
                                Colors.white,
                              ),
                              child: CoolerText(
                                leftOperand,
                                Colors.black,
                                operandFontSize,
                              ),
                            ),
                          ],
                        ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: downtownWidth,
              height: downtownHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      CoolerButton(
                        "7",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("7")
                      ),
                      Spacer(),
                      CoolerButton(
                        "8",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("8")
                      ),
                      Spacer(),
                      CoolerButton(
                        "9",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("9")
                      ),
                      Spacer(),
                      CoolerButton(
                        "+",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => operation("+")
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      CoolerButton(
                        "4",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("4")
                      ),
                      Spacer(),
                      CoolerButton(
                        "5",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("5")
                      ),
                      Spacer(),
                      CoolerButton(
                        "6",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("6")
                      ),
                      Spacer(),
                      CoolerButton(
                        "-",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => operation("-")
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      CoolerButton(
                        "1",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("1")
                      ),
                      Spacer(),
                      CoolerButton(
                        "2",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("2")
                      ),
                      Spacer(),
                      CoolerButton(
                        "3",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("3")
                      ),
                      Spacer(),
                      CoolerButton(
                        "x",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => operation("x")
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      CoolerButton(
                        "0",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => push("0")
                      ),
                      Spacer(),
                      CoolerButton(
                        ".",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => operation(".")
                      ),
                      Spacer(),
                      CoolerButton(
                        "<-",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => operation("<-")
                      ),
                      Spacer(),
                      CoolerButton(
                        "/",
                        buttonWidth,
                        buttonHeight,
                        randomColor(),
                        () => operation("/")
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class CDB {

  final double _radius;
  final Color _color;
  Decoration _decoration;

  CDB(this._radius, this._color) {
    _decoration = BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            _radius,
          )
        ),
        color: _color
      );
  }

  Decoration getProduct() {
    return this._decoration;
  }

}

class CoolerText extends StatelessWidget {
  final String _data;
  final Color _color;
  final double _fontSize;

  const CoolerText(this._data, this._color, this._fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          _data,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.bold,
            color: _color,
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
  final List<Color> _colorList;
  final Function _fn;

  CoolerButton(this._data, this._width, this._height, this._colorList, this._fn);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: CDB(makeRadius(_width, _height), _colorList.elementAt(0)).getProduct(),
      child: FlatButton(
        onPressed: _fn,
        child: CoolerText(
          _data,
          _colorList.elementAt(1),
          makeFontSize(_width, _height),
        ),
      ),
    );
  }
}