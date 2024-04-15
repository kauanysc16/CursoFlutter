import 'package:flutter/material.dart';
import 'package:sa2_correcao/View/LoginPageView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA2",
      debugShowCheckedModeBanner: false,
      home: PaginaLogin(),
    
    );
  }
}
