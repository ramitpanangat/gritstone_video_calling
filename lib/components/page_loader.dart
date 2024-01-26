import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gritstone_video_call/constants/palletes.dart';

class PageLoader extends StatelessWidget {
  final Color color;
  const PageLoader({super.key, this.color = kPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color,
      size: 40,
    );
  }
}
