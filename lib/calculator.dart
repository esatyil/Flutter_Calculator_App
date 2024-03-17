import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/num_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userQuestion = "0";
  String previousOperation = "";
  String userResult = "";

  List<String> numButtonList = [
    "C",
    "^",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "DEL",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFedf6f9),
      body: Center(
        child: Column(
          children: [
            /*Expanded(
              child: TextField(
                controller: sonucKontroller,
                decoration: const InputDecoration(
                  hintText: "0",
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 80,
                  color: Colors.black,
                ),
              ),
            ),*/
            Expanded(
              flex: 3,
              child: Column(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    color: Colors.blue,
                    child: AutoSizeText(
                      userQuestion,
                      minFontSize: 40,
                      maxFontSize: 80,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 80,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.bottomRight,
                  color: Colors.amber,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      previousOperation,
                      style:
                          const TextStyle(fontSize: 40, color: Colors.black12),
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              flex: 5,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    if (numButtonList[index] == "C") {
                      return NumTile(
                          numara: numButtonList[index],
                          color: Color(0xFFC62828),
                          textColor: Colors.white,
                          buttonTapped: () {
                            setState(() {
                              userQuestion = "0";
                              previousOperation = "0";
                            });
                          });
                    }
                    if (numButtonList[index] == "DEL") {
                      return NumTile(
                          numara: numButtonList[index],
                          color: Color(0xFFC62828),
                          textColor: Colors.white,
                          buttonTapped: () {
                            setState(() {
                              if (userQuestion.isNotEmpty ||
                                  userQuestion == "0") {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              } else {
                                userQuestion = "0";
                              }
                            });
                          });
                    }
                    if (numButtonList[index] == "=") {
                      return NumTile(
                          numara: numButtonList[index],
                          color: Colors.deepOrangeAccent,
                          textColor: Colors.white,
                          buttonTapped: () {
                            setState(() {
                              //previousOperation = userQuestion;
                              /*if (userQuestion == "0") userQuestion = "";*/
                              //userQuestion += numButtonList[index];
                              calculate();
                              userQuestion = userResult;
                            });
                          });
                    } else {
                      return NumTile(
                        numara: numButtonList[index],
                        color: isOperator(numButtonList[index])
                            ? const Color(0xFFe29578)
                            : Colors.teal,
                        textColor: isOperator(numButtonList[index])
                            ? Colors.black
                            : const Color(0xFFF6FEE5),
                        buttonTapped: () {
                          setState(() {
                            if (userQuestion == "0") userQuestion = "";
                            userQuestion += numButtonList[index];
                            //sonuc += numButtonList[index];
                            print("Basildi : ${numButtonList[index]}");
                          });
                        },
                      );
                    }
                    ;
                  }),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String numara) {
    if (numara == "+" ||
        numara == "-" ||
        numara == "/" ||
        numara == "x" ||
        numara == "=" ||
        numara == "^" ||
        numara == "%") {
      return true;
    } else {
      return false;
    }
  }

  void calculate(){

    String calculatedExp = userQuestion;
    calculatedExp = calculatedExp.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(calculatedExp);

    print(exp);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userResult = eval.toString();
    previousOperation = (exp.toString()).replaceAll("(", "").replaceAll(")", "");/*
    previousOperation = (exp.toString()).replaceAll(")", "");*/
    print(userResult);
  }
}
