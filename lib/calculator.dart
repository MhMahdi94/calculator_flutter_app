import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = '0';
  String equation = '0';
  String expression = '';
  double number2 = 0;
  processButton(btnVal) {
    //print(btnVal);
    setState(() {
      if (btnVal == 'AC') {
        equation = '0';
      } else if (btnVal == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          equation = result;
        } catch (e) {
          result = 'Error';
        }
      } else if (btnVal == '+/-') {
        //print(equation);
        var signVal = double.parse(equation) * -1;
        equation = signVal.toString();
      } else {
        if (equation == '0')
          equation = btnVal;
        else
          equation = equation + btnVal;
      }
    });
  }

  Widget calcButton(String buttonText, Color textColor, Color fillColor) {
    return Container(
        child: RawMaterialButton(
      onPressed: () {
        processButton(buttonText);
      },
      fillColor: fillColor, //Color(0xffB9D7EA)[300],
      shape: buttonText == '0' ? StadiumBorder() : CircleBorder(),
      padding: buttonText == '0'
          ? EdgeInsets.fromLTRB(34, 20, 128, 20)
          : EdgeInsets.all(15),
      child: Text(buttonText,
          style: TextStyle(fontSize: 35, color: textColor /*Colors.black*/)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF7FBFC),
        appBar: AppBar(
          title: Text(
            'Calculator',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff769FCD),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Spacer(),
              Row(
                children: [
                  Text(
                    '$equation',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 48),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('AC', Colors.white, Color(0xff769FCD)),
                  calcButton('+/-', Colors.white, Color(0xff769FCD)),
                  calcButton('%', Colors.white, Color(0xff769FCD)),
                  calcButton('/', Colors.white, Color(0xff769FCD)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('7', Colors.black, Color(0xffB9D7EA)),
                  calcButton('8', Colors.black, Color(0xffB9D7EA)),
                  calcButton('9', Colors.black, Color(0xffB9D7EA)),
                  calcButton('x', Colors.white, Color(0xff769FCD)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('4', Colors.black, Color(0xffB9D7EA)),
                  calcButton('5', Colors.black, Color(0xffB9D7EA)),
                  calcButton('6', Colors.black, Color(0xffB9D7EA)),
                  calcButton('-', Colors.white, Color(0xff769FCD)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('1', Colors.black, Color(0xffB9D7EA)),
                  calcButton('2', Colors.black, Color(0xffB9D7EA)),
                  calcButton('3', Colors.black, Color(0xffB9D7EA)),
                  calcButton('+', Colors.white, Color(0xff769FCD)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('0', Colors.black, Color(0xffB9D7EA)),
                  calcButton('.', Colors.black, Color(0xffB9D7EA)),
                  calcButton('=', Colors.white, Color(0xff769FCD)),
                ],
              ),
            ],
          )),
        ));
  }
}
