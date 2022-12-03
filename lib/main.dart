import 'package:flutter/material.dart';
import 'config.dart';

void main() async {
  // Load Application
  await initConfirgurations();

  runApp(
    const DespyApp(),
  );
}

class DespyApp extends StatelessWidget {
  const DespyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
