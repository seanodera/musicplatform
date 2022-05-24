import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:musicplatform/screens/MainShell.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ProviderModel())],
    child: const MaterialApp(
      home: SplashScreen(),
    ),
  ));
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Consumer(builder: (a, b, c) => const MainShell()))));
    return Container(
      color: Colors.redAccent.shade400,
    );
  }
}
