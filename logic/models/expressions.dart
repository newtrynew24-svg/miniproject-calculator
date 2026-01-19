abstract class Expression {
  double interpret();
}

class NumberExpression implements Expression {
  final double number;
  NumberExpression(this.number);

  @override
  double interpret() => number;
}

class AddExpression implements Expression {
  final Expression left;
  final Expression right;

  AddExpression(this.left, this.right);

  @override
  double interpret() => left.interpret() + right.interpret();
}

class MultiplyExpression implements Expression {
  final Expression left;
  final Expression right;

  MultiplyExpression(this.left, this.right);

  @override
  double interpret() => left.interpret() * right.interpret();
}

class DivisionExpression implements Expression {
  final Expression left;
  final Expression right;

  DivisionExpression(this.left, this.right);

  @override
  double interpret() => left.interpret() / right.interpret();
}

class SubtractionExpression implements Expression {
  final Expression left;
  final Expression right;

  SubtractionExpression(this.left, this.right);

  @override
  double interpret() => left.interpret() - right.interpret();
}

class PercentExpression implements Expression {
  final Expression left;
  final Expression right;

  PercentExpression(this.left, this.right);

  @override
  double interpret() => left.interpret() * (right.interpret() / 100);
}

class NegateExpression implements Expression {
  final Expression expression;

  NegateExpression(this.expression);

  @override
  double interpret() => -expression.interpret();
}