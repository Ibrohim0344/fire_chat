import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: ColoredBox(
        color: Colors.white,
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.brown,
            size: 50,
          ),
        ),
      ),
    );
  }
}
