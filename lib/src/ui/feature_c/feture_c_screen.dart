import 'package:flutter/material.dart';

class FeatureCScreenC extends StatelessWidget {
  const FeatureCScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Screen C'),
          ],
        ),
      ),
    );
  }
}
