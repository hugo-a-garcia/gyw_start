import 'package:flutter/material.dart';

class FeatureAScreenA extends StatelessWidget {
  const FeatureAScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Screen A'),
          ],
        ),
      ),
    );
  }
}
