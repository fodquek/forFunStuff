import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ZAXDE",
      home: HomeIstanbul(key),
    );
  }
}

class HomeIstanbul extends StatefulWidget {
  const HomeIstanbul(Key key) : super(key: key);
  StateOfIstanbul createState() => StateOfIstanbul();
}

class StateOfIstanbul extends State<HomeIstanbul> {

  final int upperLimit = 26;
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
      else if(upperLimit != (rightOperand.length + value.length)) {
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
        case "X":
          left *= right;
          break;
        case "/":
          left /= right;
          break;
        default:
        }
        print(left);
        if(!left.isNaN) {
          leftOperand = left.toString();
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
      backgroundColor: Colors.black,
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
                    Container(
                      width: signBoxWidth,
                      height: signBoxHeight,
                      color: Colors.white,
                      child: RaisedButton(
                        onPressed: signBoxSwitchero,
                        child: Center(
                          child: Text(
                            nonNegative ? "+" : "-",
                          ),
                        ),
                      ),
                    ), //sign box 
                    Container(
                      width: rightOperandWidth,
                      height:  rightOperandHeight,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          rightOperand,
                        ),
                      ),
                    ), //rightOperand
                  ],
                ),
                Container(
                  width: leftOperandWidth,
                  height: leftOperandHeight,
                  color: Colors.cyan,
                  child: Center(
                    child: Text(
                      leftOperand,
                    ),
                  ),
                ), //leftOperand
              ],
            ),// upperTown
            Container(
              width: downtownWidth,
              height: downtownHeight,
              color: Colors.cyanAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("7"),
                          child: Text("7"),
                        ),
                      ),// button with 7 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("8"),
                          child: Text("8"),
                        ),
                      ),// button with 8 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("9"),
                          child: Text("9"),
                        ),
                      ),// button with 9 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => operation("+"),
                          child: Text("+"),
                        ),
                      ),// button with + inside
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("4"),
                          child: Text("4"),
                        ),
                      ),// button with 4 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("5"),
                          child: Text("5"),
                        ),
                      ),// button with 5 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("6"),
                          child: Text("6"),
                        ),
                      ),// button with 6 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => operation("-"),
                          child: Text("-"),
                        ),
                      ),// button with - inside
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("1"),
                          child: Text("1"),
                        ),
                      ),// button with 1 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("2"),
                          child: Text("2"),
                        ),
                      ),// button with 2 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("3"),
                          child: Text("3"),
                        ),
                      ),// button with 3 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => operation("X"),
                          child: Text("X"),
                        ),
                      ),// button with X inside
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => push("0"),
                          child: Text("0"),
                        ),
                      ),// button with 0 inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => operation("."), //istisna durum
                          child: Text("."),
                        ),
                      ),// button with . inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => pop(),
                          child: Text("<<<"),
                        ),
                      ),// button with <<< inside

                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () => operation("/"),
                          child: Text("/"),
                        ),
                      ),// button with / inside
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