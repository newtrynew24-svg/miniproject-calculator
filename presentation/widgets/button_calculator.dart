import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ButtonCalculator extends StatefulWidget {
  String textButton;
  final Function(String) onPressed;
  Color colorButton;

  ButtonCalculator({
    super.key,
    required this.textButton,
    required this.onPressed,
    required this.colorButton
  });

  @override
  State<ButtonCalculator> createState() => _ButtonCalculatorState();
}

class _ButtonCalculatorState extends State<ButtonCalculator> {

  bool _isPressed = false;
  final double totalSize = 64.0;
  final double bevelDepth = 4.0;
  final double animationDurationMs = 50;

  @override
  Widget build(BuildContext context) {
    final double defaultInnerBevelSize = totalSize - 2 * bevelDepth;
    final double innerBevelLayerSize = totalSize - 4;
    final double contentOffset = _isPressed ? 1 : bevelDepth;
    return GestureDetector(
      onTap: () async {
        widget.onPressed(widget.textButton);
        setState(() {
          _isPressed = true;
        });
        await Future.delayed(const Duration(milliseconds: 50));
        if (!mounted) return;
        setState(() {
          _isPressed = false;
        });
      },
      child: Stack(
        children: [
          Container(width: totalSize, height: totalSize, color: AppColors.shadow),
          Positioned(
            top: 0,
            child: Container(
              width: innerBevelLayerSize,
              height: innerBevelLayerSize,
              color: AppColors.lightBevel,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: innerBevelLayerSize,
              height: innerBevelLayerSize,
              color: AppColors.darkBevel,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 50),
            top: contentOffset,
            left: contentOffset,
            width: _isPressed ? innerBevelLayerSize : defaultInnerBevelSize,
            height: _isPressed ? innerBevelLayerSize : defaultInnerBevelSize,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              child: Container(
                color: AppColors.base,
                child: Center(
                  child: Text(
                    widget.textButton,
                    style: TextStyle(
                        fontSize: 48,
                        color: widget.colorButton
                    ),
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
