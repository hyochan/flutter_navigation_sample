import 'package:flutter/material.dart';
import 'package:flutter_navigation_sample/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(height: 28),
            TextButton(
              child: const Text('설정으로 이동'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Settings(title: '설정'),
                ),
              ),
              // onPressed: () => Navigator.of(context).pushNamed('settings'),
            ),
          ],
        ),
      ),
    );
  }
}
