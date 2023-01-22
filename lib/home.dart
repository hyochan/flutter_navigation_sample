import 'package:flutter/material.dart';
import 'package:flutter_navigation_sample/navigation.dart';
import 'package:flutter_navigation_sample/routes.dart';
import 'package:flutter_navigation_sample/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.title});
  final String? title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var person = Person(name: '홍길동', age: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '홈')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(person.name),
            ),
            const SizedBox(height: 28),
            TextButton(
              child: const Text('설정으로 이동'),
              // onPressed: () => Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const Settings(title: '설정'),
              //   ),
              // ),
              // onPressed: () => Navigator.of(context).pushNamed('settings'),
              // onPressed: () => Navigator.of(context).restorablePush(
              //   (context, arguments) => MaterialPageRoute(
              //     builder: (context) => const Settings(title: '설정'),
              //   ),
              // ),
              // onPressed: () => Navigator.of(context).restorablePushNamed(
              //   '/settings',
              //   arguments: null,
              // ),
              // onPressed: () async {
              //   await Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => Settings(
              //         title: '설정',
              //         person: person,
              //       ),
              //     ),
              //   );

              //   setState(() {});
              // },
              onPressed: () => navigation.push(
                context,
                AppRoute.settings.path,
                arguments: SettingsArguments(
                  title: '설정',
                  person: person,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Person {
  Person({required this.name, required this.age});
  String name;
  final int age;
}
