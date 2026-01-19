class CalculatorInputHandler {

  final List<String> _operators = ['+', '-', '*', '/', '%'];

  List<String> handleInput(List<String> tokens, String input) {
    List<String> newTokens = List.from(tokens);

    if (input == '±') return _handleSignChange(newTokens);
    if (input == '()') return _handleParentheses(newTokens);

    if (newTokens.isEmpty) {
      return _handleEmptyState(input);
    }

    if (_isNumeric(input)) {
      return _handleNumeric(newTokens, input);
    } else if (input == '.') {
      return _handleDecimal(newTokens);
    } else if (_isOperator(input)) {
      return _handleOperator(newTokens, input);
    }

    return newTokens;
  }

  List<String> _handleEmptyState(String input) {
    if (input == '.') return ['0.'];
    if (_isNumeric(input)) return [input];
    return [];
  }

  List<String> _handleNumeric(List<String> tokens, String input) {
    String last = tokens.last;
    if (last == '0') {
      tokens[tokens.length - 1] = input;
    } else if (_isNumeric(last) || last.endsWith('.')) {
      tokens[tokens.length - 1] = last + input;
    } else if (last == ')') {
      tokens.addAll(['*', input]);
    } else {
      tokens.add(input);
    }
    return tokens;
  }

  List<String> _handleOperator(List<String> tokens, String op) {
    String last = tokens.last;

    if (_isOperator(last)) {
      if (last == '-' && tokens.length >= 2 && tokens[tokens.length - 2] == '(') {
        tokens.removeLast();
      } else {
        tokens[tokens.length - 1] = op;
      }
    } else if (last != '(') {
      tokens.add(op);
    }
    return tokens;
  }

  List<String> _handleDecimal(List<String> tokens) {
    String last = tokens.last;
    if (_isNumeric(last) && !last.contains('.')) {
      tokens[tokens.length - 1] = '$last.';
    } else if (_isOperator(last) || last == '(') {
      tokens.add('0.');
    }
    return tokens;
  }

  List<String> _handleSignChange(List<String> tokens) {
    if (tokens.isEmpty) return ['(', '-'];

    String last = tokens.last;

    if (_isNumeric(last)) {
      if (last.startsWith('-')) {
        tokens[tokens.length - 1] = last.substring(1);
        if (tokens.length >= 2 && tokens[tokens.length - 2] == '(') {
          tokens.removeAt(tokens.length - 2);
        }
      } else {
        tokens[tokens.length - 1] = '(';
        tokens.add('-$last');
      }
    } else if (_isOperator(last)) {
      tokens.addAll(['(', '-']);
    }

    return tokens;
  }

  List<String> _handleParentheses(List<String> tokens) {
    if (tokens.isEmpty) return ['('];

    String last = tokens.last;
    int openCount = tokens.where((t) => t == '(').length;
    int closeCount = tokens.where((t) => t == ')').length;

    if (_isNumeric(last) || last == ')') {
      if (openCount > closeCount) {
        tokens.add(')');
      } else {
        tokens.addAll(['*', '(']);
      }
    } else {
      tokens.add('(');
    }
    return tokens;
  }

  bool _isNumeric(String s) => double.tryParse(s) != null;
  bool _isOperator(String s) => _operators.contains(s);
}
