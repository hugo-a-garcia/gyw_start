import 'package:flutter/material.dart';

class DefualtDeviceWelcom extends StatelessWidget {
  const DefualtDeviceWelcom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Default Device Setup'),
      ),
      body: Column(
        children: [
          Text('Welcome'),
          Divider(),
          Text(
              'Your default device is not set. We will set up your device now.'),
        ],
      ),
    );
  }
}
