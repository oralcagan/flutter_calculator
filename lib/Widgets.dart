import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';

// ignore: must_be_immutable
class Screen extends StatefulWidget {
  String topLeftText = "0";
  String bottomRightText = "0";

  Screen(this.topLeftText, this.bottomRightText);

  set setTopLeft(String data) => topLeftText = data;
  set setBottomRight(String data) => bottomRightText = data;

  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  void checkTexts() {
    setState(() {
      widget.topLeftText = widget.topLeftText;
      widget.bottomRightText = widget.bottomRightText;
    });
  }

  Widget build(BuildContext context) {
    Timer.periodic(Duration(milliseconds: 100), (timer) => checkTexts());
    return Container(
      decoration: BoxDecoration(color: Colors.white54),
      child: Column(
        children: <Widget>[
          Flexible(
            child: Align(
              alignment: Alignment(-1, -1),
              child: Text(
                widget.topLeftText,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment(1, 1),
              child: Text(
                widget.bottomRightText,
                style: TextStyle(fontSize: 40, color: Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonPosition {
  int x;
  int y;
  ButtonPosition(this.x, this.y);
}

class ButtonInfo {
  var expType;
  String expString = '0';
  ButtonPosition pos = ButtonPosition(0, 0);
  void buttonPressHandler;
  void equalsHandler;
  void cHandler;
  void ceHandler;
  void delHandler;

  ButtonInfo({
    this.expType,
    this.expString,
    this.pos,
  });
}

class ButtonGrid extends StatelessWidget {
  final List<ButtonInfo> buttons;
  final buttonPressHandler;
  final equalsHandler;
  final cHandler;
  final ceHandler;
  final crossAxisCount;
  final delHandler;

  ButtonGrid(
      {@required this.buttons,
      @required this.crossAxisCount,
      @required this.ceHandler,
      @required this.cHandler,
      @required this.equalsHandler,
      @required this.delHandler,
      @required this.buttonPressHandler});

  findHandler(ButtonInfo button) {
    switch (button.expType) {
      case expTypes.c:
        return () {
          cHandler();
        };
      case expTypes.ce:
        return () {
          ceHandler();
        };
      case expTypes.equals:
        return () {
          equalsHandler();
        };
      case expTypes.del:
        return () {
          delHandler();
        };
      default:
        return () {
          buttonPressHandler(button.expString);
        };
    }
  }

  List<Widget> createButtonList() {
    List<Widget> addedButtons = [];
    var rows = buttons.length / crossAxisCount;

    for (ButtonInfo button in buttons) {
      var xPos = button.pos.x;
      var yPos = button.pos.y;

      var handler = findHandler(button);
      assert(handler != null);
      assert(button.expString != null);

      addedButtons.add(Align(
        alignment:
            Alignment(xPos * 2 / crossAxisCount - 1, yPos * 2 / rows - 1),
        child: RaisedButton(
          color: Colors.lightBlue,
          child: Text(
            button.expString,
          ),
          onPressed: findHandler(button),
        ),
      ));
    }
    return addedButtons;
  }

  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: 3/2,
      children: createButtonList(),
    );
  }
}
