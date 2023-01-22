import 'package:flutter/material.dart';
import 'package:flutter_navigation_sample/2.0/router_config.dart';
import 'package:flutter_navigation_sample/home.dart';
import 'package:flutter_navigation_sample/settings.dart';

void main() {
  // Navigation 1.0
  // runApp(const MyApp1());
  runApp(const MyApp2());
}

/// Navigation 1.0 sample
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Navigation Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: routerConfig,
    );
  }
}

/// Navigation 1.0 sample
class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Sample',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(title: 'Flutter Navigation'),
      initialRoute: 'home',
      routes: {
        'settings': (context) => const Settings(title: '설정'),
        'home': (context) => const Home(title: '홈'),
      },
    );
  }
}
