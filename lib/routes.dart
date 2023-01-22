import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigation_sample/exception.dart';

import './home.dart' show Home;
import './settings.dart' show Settings, SettingsArguments;

enum AppRoute {
  home,
  settings,
}

extension RouteName on AppRoute {
  String get name => describeEnum(this);

  /// Convert to `lower-snake-case` format.
  String get path {
    var exp = RegExp(r'(?<=[a-z])[A-Z]');
    var result =
        name.replaceAllMapped(exp, (m) => '-${m.group(0)}').toLowerCase();
    return result;
  }

  /// Convert to `lower-snake-case` format with `/`.
  String get fullPath {
    var exp = RegExp(r'(?<=[a-z])[A-Z]');
    var result =
        name.replaceAllMapped(exp, (m) => '-${m.group(0)}').toLowerCase();
    return '/$result';
  }
}

final routes = {
  AppRoute.settings.fullPath: (context) => const Home(),
  // Note that routes with args are written in [onGenerateRoute] below.
};

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  // If you push the PassArguments route
  if (settings.name == AppRoute.settings.fullPath) {
    var args = settings.arguments as SettingsArguments;

    return MaterialPageRoute(builder: (context) {
      return Settings(
        title: args.title,
        person: args.person,
      );
    });
  }

  throw NotFoundException(cause: 'Route not found: ${settings.name}');
}
