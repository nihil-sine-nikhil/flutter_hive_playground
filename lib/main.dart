import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_playground/contact_page.dart';
import 'package:hive_playground/models/contact.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }

  @override
  void dispose() {
    Hive.close();
    // Hive.box('contact').close();
    super.dispose();
  }
}
