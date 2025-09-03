import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  final double buttonSize;
  final double borderRadius;
  final Icon icon;
  final VoidCallback onPressed;

  const FlutterFlowIconButton({
    super.key,
    required this.buttonSize,
    required this.borderRadius,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }
}
