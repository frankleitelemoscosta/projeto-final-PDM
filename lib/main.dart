import 'package:flutter/material.dart';
import 'package:projeto_final/ContactsProvider.dart';
import 'package:projeto_final/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContactsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Homepage());
  }
}
