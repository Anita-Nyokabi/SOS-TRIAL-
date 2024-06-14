import 'package:flutter/material.dart';
import 'package:crime_reporting_app/report_crime_screen.dart';
import 'package:crime_reporting_app/recommendation_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crime Reporting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReportCrimeScreen(),
      routes: {
        '/recommendation': (context) => RecommendationScreen(),
      },
    );
  }
}
