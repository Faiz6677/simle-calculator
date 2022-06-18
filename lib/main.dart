
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorDark: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  dynamic equation = '0';
  dynamic result = '0';
  dynamic expression = '';
  dynamic equationFontSize = 38.0;
  dynamic resultFonSize = 48.0;

  ButtonPressed(ButtonText) {
    setState(() {
      if(ButtonText == 'C'){
        equation = '0';
        result = '0';
        equationFontSize = 38.0;
        resultFonSize = 48.0;
      } else if(ButtonText == '<'){
        equationFontSize = 48.0;
        resultFonSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ''){
          equation = '0';
        }
      } else if(ButtonText == '='){
        equationFontSize = 38.0;
        resultFonSize = 48.0;

        expression = equation;

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL,cm)}';
        }catch(e){
          result = 'some went wrong';
        }
      }
      else{
        if(equation == '0'){
          equation = ButtonText;
        } else{
          equation = equation + ButtonText;
        }
      }
    });
  }

  Widget BuildButton(String ButtonText , double ButtonHeight,Color ButtonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * ButtonHeight,
      child: FlatButton(
          color: ButtonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                color: Colors.white,
                width:  1,
                style: BorderStyle.solid,
              )
          ),
          onPressed: () => ButtonPressed(ButtonText),
          child: Text(
            ButtonText,
            style: TextStyle(
                fontSize: 30.0, color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Calculator'),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFonSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      BuildButton('C', 1, Colors.red),
                      BuildButton('<', 1, Colors.blue),
                      BuildButton('/', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      BuildButton('7', 1, Colors.black54),
                      BuildButton('8', 1, Colors.black54),
                      BuildButton('9', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton('4', 1, Colors.black54),
                      BuildButton('5', 1, Colors.black54),
                      BuildButton('6', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton('1', 1, Colors.black54),
                      BuildButton('2', 1, Colors.black54),
                      BuildButton('3', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton('.', 1, Colors.black54),
                      BuildButton('0', 1, Colors.black54),
                      BuildButton('00', 1, Colors.black54),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          BuildButton('*', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('-', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('+', 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton('=', 2, Colors.red),
                        ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
