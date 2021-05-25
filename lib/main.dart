import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var input = '';
  var result = '';
  List<String> buttons = [
    'C',
    '+/-',
    '%',
    '<-',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.tealAccent,
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Calculator",
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 15,
                      right: 15,
                      bottom: 5,
                    ),
                    alignment: Alignment.centerRight,
                    child: Text(
                      input,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.teal,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 15,
                      right: 15,
                      bottom: 5,
                    ),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Button(
                      tapped: () {
                        setState(() {
                          input = '';
                          result = '0';
                        });
                      },
                      buttonText: buttons[index],
                      buttonColor: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  } else if (index == 1) {
                    return Button(
                      buttonText: buttons[index],
                      buttonColor: Colors.blue[50],
                      textColor: Colors.black,
                      tapped: () {
                        int number = int.parse(input);
                        number = -number;
                        setState(() {
                          input = number.toString();
                        });
                      },
                    );
                  } else if (index == 2) {
                    return Button(
                      tapped: () {
                        setState(() {
                          input += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      buttonColor: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  } else if (index == 3) {
                    return Button(
                      tapped: () {
                        setState(() {
                          input = input.substring(0, input.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      buttonColor: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  } else if (index == 18) {
                    return Button(
                      tapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      buttonColor: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  } else {
                    return Button(
                      tapped: () {
                        setState(() {
                          input += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      buttonColor: isOperator(buttons[index])
                          ? Colors.blueAccent
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalInput = input;
    finalInput = input.replaceAll('x', '*');
    Parser parser = Parser();
    Expression exp = parser.parse(finalInput);
    ContextModel contextModel = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, contextModel);
    result = eval.toString();
  }
}
