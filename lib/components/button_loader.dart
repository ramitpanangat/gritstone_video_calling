import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ButtonLoader extends StatelessWidget {
  final Color color;
  const ButtonLoader({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return  SpinKitRing(
      color: color,
      size: 20,
      lineWidth: 3,
    );
  }
}
