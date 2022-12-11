import 'package:despy_app/features/view/controllers/transaction_controller.dart';
import 'package:despy_app/features/view/pages/data_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config.dart';

void main() async {
  // Load Application
  await initConfirgurations();

  runApp(const DespyApp());
}

class DespyApp extends StatelessWidget {
  const DespyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionController(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TestPage(),
      ),
    );
  }
}
