import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class AdvancedCalculatorProvider with ChangeNotifier {
  String baseInput ="";
  String baseResult = "0";
  bool isDegree = true;
  bool isInverse = false;

  List<String> baseButtonList = [
    "INV", "RAD", "!", "AC", "/", "x", "C",
    "sin", "cos", "tan", "7", "8", "9", "-",
    "ln", "log", "xY", "4", "5", "6", "+",
    "π", "e", "√", "1", "2", "3", "%",
    "(", ")", "Deg", "x²", "0", ".", "=",
  ];

  List<String> inverseButtonList = [
    "INV", "RAD", "!", "AC", "/", "x", "C",
    "sin−1", "cos−1", "tan−1", "7", "8", "9", "-",
    "ln", "log", "xY", "4", "5", "6", "+",
    "π", "e", "√", "1", "2", "3", "%",
    "(", ")", "Deg", "x²", "0", ".", "=",
  ];

  List<String> get buttonList => isInverse ? inverseButtonList : baseButtonList;

  Color getButtonColor(String text, BuildContext context) {
    if (text == "C" || text == "AC") {
      return const Color.fromARGB(225, 252, 100, 100);
    } else if (text == "=") {
      return Colors.green;
    }
    return const Color(0xFF1d2630);
  }
  Color getButtonTextColor(String text, BuildContext context) {
    if (text == "/" || text == "x" || text == "+" || text == "-" || text == "%") {
      return const Color.fromARGB(225, 252, 100, 100);
    }
    return Colors.white;
  }
  String userCalculate(BuildContext context,) {
    try {
      String formattedInput = baseInput
          .replaceAll('x', '*')
          .replaceAll('%', '/100')
          .replaceAll('π', '3.14159265359')
          .replaceAll('e', '2.71828182846')
          .replaceAll('√', 'sqrt');

      if (isDegree) {
        formattedInput = formattedInput.replaceAllMapped(
          RegExp(r'sin\((.*?)\)'),
              (match) => 'sin(${match.group(1)}* ${3.14159265359/180})',
        );
        formattedInput = formattedInput.replaceAllMapped(
          RegExp(r'cos\((.*?)\)'),
              (match) => 'cos(${match.group(1)} * ${3.14159265359/180})',
        );
        formattedInput = formattedInput.replaceAllMapped(
          RegExp(r'tan\((.*?)\)'),
              (match) => 'tan(${match.group(1)}* ${3.14159265359/180})',
        );
      }
      if (isInverse) {
        formattedInput = formattedInput.replaceAllMapped(
          RegExp(r'sin−1\((.*?)\)'),
              (match) => 'sin(${match.group(1)})',
        );
        formattedInput = formattedInput.replaceAllMapped(
          RegExp(r'cos−1\((.*?)\)'),
              (match) => 'cos(${match.group(1)})',
        );
        formattedInput = formattedInput.replaceAllMapped(
          RegExp(r'tan−1\((.*?)\)'),
              (match) => 'tan(${match.group(1)})',
        );
      }
      Parser parser = Parser();
      Expression exp = parser.parse(formattedInput);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);

      String result = eval.toString();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      baseResult = result;
      return result;
    } catch (e) {
      baseResult = "Error: Invalid input";
      return "Error: Invalid input";
    }
  }
  void userHandleButton(String text, BuildContext context) {
    if (text == "AC") {
      baseInput = "";
      baseResult = "0";
    } else if (text == "=") {
      baseResult = userCalculate(context);
    } else if (text == "C") {
      if (baseInput.isNotEmpty) {
        baseInput = baseInput.substring(0, baseInput.length - 1);
        notifyListeners();
      }
      baseResult = "0";
      notifyListeners();
    } else if (text == "RAD" || text == "Deg") {
      isDegree = !isDegree;
      notifyListeners();
    } else if (text == "INV") {
      isInverse = !isInverse;
      notifyListeners();
    } else if (text == "x²") {
      if (baseInput.isNotEmpty) {
        final lastNumber = _extractLastNumber(baseInput);
        if (lastNumber != null) {
          final square = (double.parse(lastNumber) * double.parse(lastNumber)).toString();
          baseInput = baseInput.substring(0, baseInput.length - lastNumber.length) + square;
          baseResult = square;
        }
      } else {
        baseInput = "0";
        baseResult = "0";
        notifyListeners();
      }
    } else if (text == "!") {
      if (baseInput.isNotEmpty) {
        final lastNumber = _extractLastNumber(baseInput);
        if (lastNumber != null) {
          final number = int.parse(lastNumber);
          final factorial = _calculateFactorial(number).toString();
          baseInput = baseInput.substring(0, baseInput.length - lastNumber.length) + factorial;
          baseResult = factorial;
        }
        notifyListeners();
      }
    } else {
      baseInput += text;
    }
    notifyListeners();
  }
  int _calculateFactorial(int number) {
    if (number <= 1) return 1;
    return number * _calculateFactorial(number - 1);
  }

  String? _extractLastNumber(String input) {
    final match = RegExp(r'(\d+\.?\d*)$').firstMatch(input);
    return match?.group(1);
  }
}
