import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../presentation/widgets/button_calculator.dart';
import '../../logic/parser/calculator_parser.dart';

import '../controller/calculator_controller.dart';

class ScreenCalculator extends StatefulWidget {
  const ScreenCalculator({super.key});

  @override
  State<ScreenCalculator> createState() => _ScreenCalculatorState();
}

class _ScreenCalculatorState extends State<ScreenCalculator> {

  final CalculatorController _controller = CalculatorController();

  final calculatorParser = CalculatorParser();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(width: 344, height: 572, color: AppColors.shadow),
            Positioned(
                top: 0,
                left: 0,
                width: 340,
                height: 568,
                child: Container(
                  color: AppColors.base,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 24,),
                        ListenableBuilder(
                            listenable: _controller,
                          builder: (context, _) {
                              return _buildDisplay(_controller.displayText);
                          },
                        ),
                        const SizedBox(height: 16,),
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              _buildButton('C', AppColors.btnTextC),
                              _buildButton('()', AppColors.btnTextParentheses),
                              _buildButton('%', AppColors.btnTextPercent),
                              _buildButton('/', AppColors.btnTextOperator),
                              _buildButton('7', AppColors.btnTextNumber),
                              _buildButton('8', AppColors.btnTextNumber),
                              _buildButton('9', AppColors.btnTextNumber),
                              _buildButton('*', AppColors.btnTextOperator),
                              _buildButton('4', AppColors.btnTextNumber),
                              _buildButton('5', AppColors.btnTextNumber),
                              _buildButton('6', AppColors.btnTextNumber),
                              _buildButton('-', AppColors.btnTextOperator),
                              _buildButton('1', AppColors.btnTextNumber),
                              _buildButton('2', AppColors.btnTextNumber),
                              _buildButton('3', AppColors.btnTextNumber),
                              _buildButton('+', AppColors.btnTextOperator),
                              _buildButton('±', AppColors.btnTextNumber),
                              _buildButton('0', AppColors.btnTextNumber),
                              _buildButton('.', AppColors.btnTextNumber),
                              _buildButton('=', AppColors.btnTextOperator),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 42,
      width: 328,
      decoration: BoxDecoration(
          color: Colors.black
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text(
          'Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
          textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
        ),
      ),
    );
  }

  Widget _buildDisplay(String text) {
    String textInput = _controller.displayText;
    return Container(
      height: 78,
      width: 304,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: AppColors.screenBackground,
        border: Border(
          top: BorderSide(color: AppColors.shadow, width: 4),
          left: BorderSide(color: AppColors.shadow, width: 4),
        ),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            textInput.isEmpty ? '0' : textInput,
            style: TextStyle(
              color: Colors.black,
              fontSize: 64,
            ),
            maxLines: 1,
            textHeightBehavior: TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String textButton, Color colorButton) {
    return ButtonCalculator(
        textButton: textButton,
        onPressed: (text) => _controller.onButtonPressed(text),
        colorButton: colorButton
    );
  }
}

