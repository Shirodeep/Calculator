import 'package:batti/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
      title: 'Calculator App',
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String input = "0";
  var output = "0";
  bool minusFlip =  false;
  bool equals = false;
  bool checkOperatorFault(String checkFault){
    if(checkFault.length > 1){
      String key2 =  checkFault.substring(checkFault.runes.length - 1);
      String key =  checkFault.substring(checkFault.length);
      if(input.length > 14){
        return true;
      }
      if(key2 == key){
        // print("l");
        return true;
      }
    }
  return false;
  }
  onButtonClick(String value) {
    setState(() {
      if(equals == true){
        input = output;
        equals = false;
      }
      if(input == "0" && input.length == 1 && value != "0"){
      input = "";
      }
      switch (value) {
        case "0":
           break;
        case "AC":
          input = "0";
          minusFlip = false;
          output = "0";
          break;
        case "+/-":
          if (minusFlip == false){
            input =  "-${input}";
            minusFlip = true;
          }else if(minusFlip == true){
            input = input.substring(1, input.length);
            minusFlip = false;
          }
          break;
        case "÷":
          if(input == ""){
            input = "0";
          }
          else{
            input = input + value;
            if(checkOperatorFault(input) == true){
              input = input.substring(0, input.length -1);
            }
          
          }
          break;
        case "-":
          if(input == ""){
            input = "0";
          }
          else{
            input = input + value;
            if(checkOperatorFault(input) == true){
              input = input.substring(0, input.length -1);
            }
          
          }
          break;
        case "+":
          if(input == ""){
            input = "0";
          }
          else{
            input = input + value;
            if(checkOperatorFault(input) == true){
              input = input.substring(0, input.length -1);
            }
          
          }
          break;
        case "x":
          if(input == ""){
            input = "0";
          }
          else{
            input = input + value;
            if(checkOperatorFault(input) == true){
              input = input.substring(0, input.length -1);
            }  
          }
          break;  
        case "%":
          var input1 = int.parse(input) / 100;
          input = input1.toString();
          break;
        case "=": 
          String changeChar = input;
          changeChar = input.replaceAll(RegExp(r'x'), "*");
          changeChar = input.replaceAll(RegExp(r'÷'), "/");
          Parser p  = Parser();
          Expression exp = p.parse(changeChar);
          ContextModel cm = ContextModel();
          double answer = exp.evaluate(EvaluationType.REAL, cm);
          output = answer.toString();
          equals = true;
          break; 
        default:
        if(input.length < 14){
          input = input + value;
        }
      }
    }
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Column(
          children: [
            // i/o ko lagi
            Expanded(
                child: Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(padding: const EdgeInsets.all(10)),
                  Text(
                    input,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 100, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(output,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 80,
                          color: Color.fromARGB(255, 223, 214, 214))),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
            //button ko lagi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(
                    text: "AC",
                    buttonBgColor: operatorColor,
                    tcolor: blackColor),
                button(
                    text: "+/-",
                    buttonBgColor: operatorColor,
                    tcolor: blackColor),
                button(
                    text: "%",
                    buttonBgColor: operatorColor,
                    tcolor: blackColor),
                button(text: "÷", buttonBgColor: orangecolor)
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              button(text: "7", buttonBgColor: buttonColor),
              button(text: "8", buttonBgColor: buttonColor),
              button(text: "9", buttonBgColor: buttonColor),
              button(text: "x", buttonBgColor: orangecolor)
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              button(text: "4", buttonBgColor: buttonColor),
              button(text: "5", buttonBgColor: buttonColor),
              button(text: "6", buttonBgColor: buttonColor),
              button(text: "-", buttonBgColor: orangecolor)
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              button(text: "1", buttonBgColor: buttonColor),
              button(text: "2", buttonBgColor: buttonColor),
              button(text: "3", buttonBgColor: buttonColor),
              button(text: "+", buttonBgColor: orangecolor)
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.grey,
                      padding: const EdgeInsets.fromLTRB(40, 18, 138, 15)),
                  onPressed: () => onButtonClick("0"),
                  child: const Text(
                    "0",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                button(text: ".", buttonBgColor: buttonColor),
                button(text: "=", buttonBgColor: orangecolor)
              ],
            )
          ],
        ));
  }

  Widget button({text, tcolor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(2),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                primary: buttonBgColor,
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () => onButtonClick(text),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 35, color: tcolor, fontWeight: FontWeight.bold),
              ),
            )));
  }
}