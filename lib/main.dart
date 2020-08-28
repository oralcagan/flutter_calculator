import 'package:flutter/material.dart';
import 'Calculation.dart';
import 'Widgets.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalculatorState();
  }
}



enum expTypes { equals, c, ce, del }

class CalculatorState extends State<Calculator> {
  String topLeftText = '0';
  String bottomRightText = '0';

  List<ButtonInfo> buttons = [
    ButtonInfo(pos: ButtonPosition(0,0), expString: '^', expType: null),
    ButtonInfo(pos: ButtonPosition(1,0), expString: 'C',expType: expTypes.c),
    ButtonInfo(pos: ButtonPosition(2,0), expString: 'CE',expType: expTypes.ce),
    ButtonInfo(pos: ButtonPosition(3,0), expString: 'DEL',  expType: expTypes.del),
    ButtonInfo(pos: ButtonPosition(0,1), expString: '7', expType: null),
    ButtonInfo(pos: ButtonPosition(1,1), expString: '8', expType: null),
    ButtonInfo(pos: ButtonPosition(2,1), expString: '9', expType: null),
    ButtonInfo(pos: ButtonPosition(3,1), expString: '*',  expType: null),
    ButtonInfo(pos: ButtonPosition(0,2), expString: '4',  expType: null),
    ButtonInfo(pos: ButtonPosition(1,2), expString: '5', expType: null),
    ButtonInfo(pos: ButtonPosition(2,2), expString: '6',  expType: null),
    ButtonInfo(pos: ButtonPosition(3,2), expString: '/', expType: null),
    ButtonInfo(pos: ButtonPosition(0,3), expString: '1', expType: null),
    ButtonInfo(pos: ButtonPosition(1,3), expString: '2', expType: null),
    ButtonInfo(pos: ButtonPosition(2,3), expString: '3', expType: null),
    ButtonInfo(pos: ButtonPosition(3,3), expString: '+',expType: null),
    ButtonInfo(pos: ButtonPosition(0,4), expString: '=', expType: expTypes.equals),
    ButtonInfo(pos: ButtonPosition(1,4), expString: '0', expType: null),
    ButtonInfo(pos: ButtonPosition(3,4), expString: '.', expType: null),
    ButtonInfo(pos: ButtonPosition(2,4), expString: '-', expType: null),
  ];

  Screen calcScreen = Screen('0', '0');

  void buttonPressHandler(String expString) {
    if(bottomRightText == '0') {
      bottomRightText = expString;
      calcScreen.bottomRightText = bottomRightText;
    }
    else {
      bottomRightText += expString;
      calcScreen.bottomRightText = bottomRightText;
    }
  }

  void ceHandler() {
    bottomRightText = '0';
    calcScreen.bottomRightText = '0';
  }

  void cHandler() {
    topLeftText = '';
    bottomRightText = '0';
    calcScreen.bottomRightText = '0';
    calcScreen.topLeftText = '';
  }

  void equalsHandler() {
    topLeftText = bottomRightText + '=' + returnResult(bottomRightText);
    bottomRightText = returnResult(bottomRightText);
    calcScreen.bottomRightText = bottomRightText;
    calcScreen.topLeftText = topLeftText;
  }

  void delHandler() {
    if(bottomRightText.length > 1) {
      bottomRightText = bottomRightText.substring(0,bottomRightText.length-1);
      calcScreen.bottomRightText = bottomRightText;
    }
    else {
      bottomRightText = '0';
      calcScreen.bottomRightText = bottomRightText;
    }
  }

  Widget build(BuildContext ctx) {
    ButtonGrid buttonGrid = ButtonGrid(buttons: buttons, crossAxisCount: 4, cHandler: cHandler, buttonPressHandler: buttonPressHandler, delHandler: delHandler, ceHandler: ceHandler, equalsHandler: equalsHandler);

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: calcScreen,
            flex: 2,
          ),
          Expanded(
            flex: 6,
            child: buttonGrid,
          ),
        ],
      ),
    ));
  }
}