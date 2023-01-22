import 'dart:async';

import 'package:flutter/material.dart';

typedef NavigationArguments<T> = T;

class _Navigation {
  factory _Navigation() {
    return _singleton;
  }

  _Navigation._internal();
  static final _Navigation _singleton = _Navigation._internal();

  Future<dynamic> push(BuildContext context, String routeName,
      {bool reset = false, NavigationArguments? arguments}) {
    if (reset) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        '/$routeName',
        ModalRoute.withName('/$routeName'),
        arguments: arguments,
      );
    }

    return Navigator.of(context).pushNamed('/$routeName', arguments: arguments);
  }

  void pop<T extends dynamic>(
    BuildContext context, {
    T? params,
  }) {
    return Navigator.pop(context, params);
  }

  void popUtil(
    BuildContext context,
    String routeName,
  ) {
    return Navigator.popUntil(
      context,
      (route) {
        return route.settings.name == '/$routeName';
      },
    );
  }
}

var navigation = _Navigation();
