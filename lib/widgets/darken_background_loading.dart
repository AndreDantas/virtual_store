import 'package:flutter/material.dart';

class DarkenBackgroundLoading extends StatelessWidget {
  final double opacity;
  final Color loadingColor;

  DarkenBackgroundLoading({
    this.opacity = 0.3,
    this.loadingColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.black.withOpacity(opacity),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(loadingColor),
        ),
      ),
    );
  }
}
