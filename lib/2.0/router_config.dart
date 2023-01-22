import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigation_sample/settings.dart';
import 'package:go_router/go_router.dart';

import '../home.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum GoRoutes {
  home,
  settings,
}

extension GoRoutesName on GoRoutes {
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

final routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: GoRoutes.home.fullPath,
  errorBuilder: (context, state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Error: ${state.error}'),
    );
  },
  routes: <RouteBase>[
    GoRoute(
      name: GoRoutes.home.name,
      path: GoRoutes.home.fullPath,
      builder: (context, state) {
        return const Home();
      },
    ),
    GoRoute(
      name: GoRoutes.settings.name,
      path: GoRoutes.settings.fullPath,
      builder: (context, state) {
        var args = state.extra as SettingsArguments;

        return Settings(
          title: state.queryParams['title']!,
          person: args.person,
        );
      },
    ),
  ],
);
