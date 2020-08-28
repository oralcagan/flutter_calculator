import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String returnResult(String unparsedString) {
  Parser stringParser = Parser();
  print(unparsedString);
  try {
    Expression parsedString = stringParser.parse(unparsedString);
    ContextModel cm = ContextModel();
    var result = parsedString.evaluate(EvaluationType.REAL, cm);

    print('Result: $result');
    return result.toString();
  } catch (err) {
    print(err);
    return 'Error';
  }
}