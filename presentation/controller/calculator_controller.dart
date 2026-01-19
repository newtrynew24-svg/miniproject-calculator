import 'package:flutter/material.dart';
import 'package:retro_calculator_test/logic/parser/calculator_parser.dart';

import '../../logic/handlers/calculator_input_handler.dart';

class CalculatorController extends ChangeNotifier {
  final CalculatorParser _parser = CalculatorParser();
  final CalculatorInputHandler _inputHandler = CalculatorInputHandler();

  List<String> _tokens = [];

  String get displayText => _tokens.isEmpty ? '0' : _tokens.join('');

  void onButtonPressed(String buttonText) {
    if (_tokens.isNotEmpty && _tokens.last == 'ERROR') {
      _clear();
    }
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '=') {
      _calculateResult();
    } else {
      _tokens = _inputHandler.handleInput(_tokens, buttonText);
    }
    notifyListeners();
  }

  void _clear() {
    _tokens.clear();
  }

  void _calculateResult() {
    if (_tokens.isEmpty) return;
    try {
      final expression = _parser.parse(_tokens);
      final result = expression.interpret();
      String formatted = _formatResult(result);
      _tokens = [formatted];
    } catch (e) {
      _tokens = ['ERROR'];
    }
  }

  String _formatResult(double result) {
    if (result % 1 == 0) {
      return result.toInt().toString();
    }
    return result.toStringAsFixed(6)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }

}
