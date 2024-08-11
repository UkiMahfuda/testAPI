import 'package:flutter/material.dart';
import 'package:myapp/navbar.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: MyNavbar(),
        body: ListView(
          children: [
            Row(
              children: [Text("Text View Data")],
            )
          ],
        ),
      ),
    );
  }
}
