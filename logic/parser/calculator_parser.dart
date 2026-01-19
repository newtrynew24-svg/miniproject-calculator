import '../models/expressions.dart';

class CalculatorParser {
  final List<Expression> values = [];
  final List<String> operators = [];

  Expression parse(List<String> tokens) {
    values.clear();
    operators.clear();
    return _buildTree(List.from(tokens));
  }

  void _applyOperator() {
    if (operators.isEmpty) throw StateError('No operator to apply');
    final operator = operators.removeLast();

    if (operator == 'u-') {
      if (values.isEmpty) throw StateError('No value for unary operator');
      final value = values.removeLast();
      values.add(NegateExpression(value));
    } else {
      if (values.length < 2) throw StateError('Not enough values for operator');
      final right = values.removeLast();
      final left = values.removeLast();
      switch (operator) {
        case '+':
          values.add(AddExpression(left, right));
          break;
        case '-':
          values.add(SubtractionExpression(left, right));
          break;
        case '*':
          values.add(MultiplyExpression(left, right));
          break;
        case '/':
          if (right.interpret() == 0) throw ArgumentError('Division by zero');
          values.add(DivisionExpression(left, right));
          break;
        case '%':
          values.add(PercentExpression(left, right));
          break;
        default:
          throw ArgumentError('Unknown operator: $operator');
      }
    }
  }

  int _priority(String op) {
    switch (op) {
      case '+':
      case '-':
        return 1;
      case '*':
      case '/':
        return 2;
      case '%':
        return 3;
      case 'u-':
        return 4;
      default:
        return 0;
    }
  }

  bool _isNumber(String token) {
    if (token.isEmpty) return false;
    final number = double.tryParse(token);
    return number != null;
  }

  double _parseNumber(String token) {
    return double.parse(token);
  }

  Expression _buildTree(List<String> tokens) {
    for (int i = 0; i < tokens.length; i++) {
      final token = tokens[i];
      final prevToken = i > 0 ? tokens[i - 1] : null;

      if (_isNumber(token)) {
        values.add(NumberExpression(_parseNumber(token)));
      } else if (token == '(') {
        operators.add(token);
      } else if (token == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          _applyOperator();
        }
        if (operators.isEmpty) {
          throw ArgumentError(
            'Mismatched parentheses: missing opening bracket',
          );
        }
        operators.removeLast();
      } else if (token == '-' ||
          token == '+' ||
          token == '*' ||
          token == '/' ||
          token == '%') {
        if (token == '-') {
          bool isUnary =
              (i == 0) ||
              (prevToken == '(') ||
              (prevToken != null &&
                  ['+', '-', '*', '/', '%', '('].contains(prevToken));
          if (isUnary) {
            operators.add('u-');
            continue;
          }
        }

        while (operators.isNotEmpty &&
            operators.last != '(' &&
            _priority(operators.last) >= _priority(token)) {
          _applyOperator();
        }
        operators.add(token);
      } else {
        throw ArgumentError('Unknown token: $token');
      }
    }

    while (operators.isNotEmpty) {
      if (operators.last == '(') {
        throw ArgumentError('Mismatched parentheses: missing closing bracket');
      }
      _applyOperator();
    }

    if (values.isEmpty) {
      throw StateError('No expression parsed');
    }

    return values.last;
  }
}
