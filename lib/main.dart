import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_playground/contact_page.dart';

Future<void> main() async {
  await Hive.initFlutter();

  runApp(
    MaterialApp(
      home: FutureBuilder(
          future: Hive.openBox('contacts'),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else
                return ContactPage();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(
                color: Colors.blue,
              )));
            }
            return Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
              color: Colors.red,
            )));
          }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    ),
  );
}
