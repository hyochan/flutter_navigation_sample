import 'package:flutter/material.dart';
import 'package:flutter_navigation_sample/2.0/router_config.dart';
import 'package:flutter_navigation_sample/settings.dart';
import 'package:go_router/go_router.dart';
import '1.0/navigation.dart';
import '1.0/routes.dart';

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
              // onPressed: () => navigation.push(
              //   context,
              //   AppRoute.settings.path,
              //   arguments: SettingsArguments(
              //     title: '설정',
              //     person: person,
              //   ),
              // ),

              /// go_router
              // onPressed: () => context.push(
              //   GoRoutes.settings.name,
              //   extra: SettingsArguments(title: '설정', person: person),
              // ),
              onPressed: () => context.pushNamed(
                GoRoutes.settings.name,
                queryParams: {'title': '설정'},
                extra: SettingsArguments(title: '설정', person: person),
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
