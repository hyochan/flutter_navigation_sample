# flutter_navigation_sample

플러터 네비게이션 정리

## 1. Built-in 네비게이션

### 목차

<ul>
  <li>1.1 네비게이션 사용</li>
  <li>1.2 기본적인 기능들 (push, pop, etc)</li>
  <li>1.3 복원 가능한 네비게이션</li>
  <li>1.4 네비게이션 변수 다루기</li>
  <li>1.5 미비한 기능 (navigate)</li>
  <li>1.6 실사용 예시</li>
</ul>

### 1.1 네비게이션 사용

<details>
<summary>프로젝트 생성</summary>

  ```sh
  flutter create flutter_navigation_sample
  ```
</details>

<details>
<summary>라우터 설정</summary>

  ```dart
  return MaterialApp(
    initialRoute: 'home',
    routes: {
      'settings': (context) => const Settings(title: '설정'),
      'home': (context) => const Home(title: '홈'),
    },
  );
  ```
</details>


### 1.2 기본적인 기능들

<details>
<summary>1.2.1 push</summary>

  화면 이동시 사용한다. 스택으로 화면을 쌓는다.

  ```dart
  Navigator.of(context).push(
    MaterialPageRoute우
      builder: (context) => const Settings(title: '설정'),
    ),
  );
  ```

  <details>
  <summary><span style="color: #47498A">Named route</span></summary>

  ```dart
  Navigator.of(context).pushNamed('settings', arguments: null);
  ```
  > Named route에서는 arguments를 보내기 위해서 특별히 `arguments` 파라미터를 제공한다.
  </details>
</details>

<details>
<summary>1.2.2 pop</summary>

  뒤로가기. 현재 화면을 날린다.

  ```dart
  Navigator.of(context).pop();
  ```
</details>

<details>
<summary>1.2.3 popUtil</summary>

  [React Navigation의 reset](https://reactnavigation.org/docs/navigation-prop/#reset)과 유사하다.

  ```dart
  Navigator.popUntil(
    context,
    (route) {
      return route.settings.name == '/$routeName';
    },
  );
  ```

  ```dart
  Navigator.of(context).popUntil((route) => route.isFirst);
  ```
</details>

<details>
<summary>1.2.4 pushReplacement</summary>

  화면 이동시 사용한다. 현재 화면을 비우고 넘어간다. [React navigation의 replace](https://reactnavigation.org/docs/stack-actions/#replace)와 유사하다.

  ```dart
  Navigator.pushReplacement<T, TO>(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
  ```

  <details>
  <summary><span style="color: #47498A">Named route</span></summary>

  ```dart
  Navigator.of(context).pushReplacementNamed('/$routeName', arguments: arguments);
  ```
  </details>
</details>


### 1.3 복원 가능한 네비게이션
앱이 백그라운드에 가서 메모리 부족으로 앱에서 사용하는 메모리가 날라갔을 때 다시 foreground 상태에서 이전 state를 복원하는 기능을 제공한다. 궁금하면 [해당 글](https://itnext.io/state-restoration-in-flutter-b6030b95a4d4)을 참고한다.

<details>
<summary>1.3.1 restorablePush</summary>

  화면 이동시 사용한다. 스택으로 화면을 쌓는다.

  ```dart
  Navigator.of(context).restorablePush(
    (context, arguments) => MaterialPageRoute(
      builder: (context) => const Settings(title: '설정'),
    ),
  );
  ```

  <details>
  <summary><span style="color: #47498A">Named route</span></summary>

  ```dart
  Navigator.of(context).restorablePushNamed(
    '/settings',
    arguments: null,
  );
  ```
  </details>

  > `restorablePush`외에도 `restorablePushAndRemoveUntil`, `restorablePushNamed`, `restorablePushReplacement`, `restorablePushNamed` 등 기본 기능에 있는 모든 것들이 지원된다. **Restorable**을 사용시 주의해야할 부분은 argument들이 `primitive` 타입이어야 한다. 이는 **[React Navigation에서 권장하는 parameter]** 들과 동일하다.
</details>

### 1.4 네비게이션 변수 다루기

<details>
<summary>1.4.1 화면 전환 시 변수 담아 보내기</summary>

  화면 이동시 대상 화면에 필요한 arguments를 담으면 된다. 아래 예시 같은 경우 `title`을 전달한다.

  ```dart
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const Settings(title: '설정'),
    ),
  );
  ```
  
  Named route의 경우 추가적으로 `arguments` 파라미터가 제공되며 이를 사용하면 된다.
  아래와 같은 경우 `SettingsArguments`를 따로 지정한다.

  ```dart
  Navigator.of(context).pushNamed(
    'settings',
    arguments: SettingsArguments(title: '설정'),
  );
  ```
</details>

<details>
<summary>1.4.2 변수 반환하기</summary>

  <details>
  <summary><span style="color: #47498A">1.4.2.1 화면으로부터 반환</span></summary>

  Flutter 같은 경우 대상 화면으로부터 결과값을 받을 수 있음. 대상 화면으로 전환하면서 `await` 문을 써서 결과 반환을 기다린다. 대상 화면에서는 `pop`과 동시에 추가 arguments를 반환한다.

  ```dart
  /// 소스 화면
  var result = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const Settings(title: '설정'),
    ),
  );

  /// 대상 화면
  Navigation.of(context).pop(context, '결과값');
  ```
  </details>

  <details>
  <summary><span style="color: #47498A">1.4.2.1 콜백으로 결과 받아오기</span></summary>

  화면에서 리턴되는 값을 통해 값을 받아올 수도 있지만 콜백 함수로도 값을 받아올 수 있다.

  ```dart
  var result = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const Settings(
        title: '설정',
        callback: (result) => print('결과값: $result'),
      ),
    ),
  );
  ```

  위에서 유의할 부분은 해당 화면의 `state` 변경을 시도하는 경우 `mounted` 된 상태를 확인해야 한다. 플러터에서는 화면이 `dispose` 되는 상황에 대해 `state`를 변경하기 전에 이를 확인하는 예외를 처리하는 것이 좋다.

  ```dart
  var result = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const Settings(
        title: '설정',
        callback: (result) => mounted ? setState(() => value = result) : null,
      ),
    ),
  );
  ```
  </details>
</details>

<details>
<summary>1.4.3 네비게이션 인수 타입</summary>

  - 플러터의 경우 React Navigation에서 권장하는 것과 달리 primitive 타입만 인수로 보내주지 않는다.
  - 클래스나 함수도 같이 보내지지만 JS에서와는 다르게 주소값이 들어가기 때문에 대상 화면에서 변경된 클래스 변수들의 값이 부모 화면에서 변경이 된다.

    <img src="https://user-images.githubusercontent.com/27461460/213905632-2856b138-3a96-489c-9c0e-4b3dab79a6de.gif" width="200">

</details>

### 1.5 미비한 기능

<details>
<summary>1.5.1 Navigate</summary>

  [React Navigation의 navigate](https://reactnavigation.org/docs/navigation-prop/#navigate)와 같은 함수가 없음. 이럴 경우 아래와 같이 사용한다.

  ```dart
  Navigator.of(context).pushNamedAndRemoveUntil(
    '/$routeName',
    (route) =>
        route.isCurrent && route.settings.name == routeName ? false : true,
    arguments: arguments,
  );
  ```
</details>

<details>
<summary>1.5.2 Type safe</summary>

  `import` 문을 줄이기 위해서 named route를 선호하지만 이는 type safe 하지 않는다.

  - 아래와 같이 `enum`으로 화면명을 관리한다.
    ```dart
    enum AppRoute {
      home,
      settings
    }
    ```

  <details>
  <summary>1.5.2.1 With extensions</summary>

  `import` 문을 줄이기 위해서 named route를 선호하지만 이는 type safe 하지 않음.

  - 아래와 같이 `enum`으로 화면명을 관리한다.
    ```dart
    enum AppRoute {
      home,
      settings
    }
    ```

  - `Typescript`와는 다르게 `dartlang`에는 enum을 매핑해서 사용할 수가 없다. 하지만 Flutter web을 사용한다고 가정하였을 때 해당 route는 `/homeMore`, `/userDetails` 등 `camelCase`로 나타나게 되고 이러한 url 명칭은 개발자들에게 익숙하지 않다. 이런 문제를 `dart`에서는 `C#`에 있는 [extension methods](https://dart.dev/guides/language/extension-methods)를 사용하여 해결 할 수 있다.

    ```dart
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
        if (isRoot) return '/';

        var exp = RegExp(r'(?<=[a-z])[A-Z]');
        var result =
            name.replaceAllMapped(exp, (m) => '-${m.group(0)}').toLowerCase();
        return '/$result';
      }
    }
    ```
    
    위와 같이 extension을 달면 `AppRoute.homeDetails.path`는 `/home-details`로 치환된다.
  </details>
</details>


### 1.6 실사용 예시

<details>
  <summary>1.6.1 `navigation.dart`</summary>

  Flutter navigator를 호출하는 코드가 다소 길어서 `navigation.dart`에 자주쓰는 함수를 정의한다.

  ```dart
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
  ```
</details>

<details>
<summary>1.6.2 `routes.dart`</summary>

  routes에 들어가는 내용을 별도 파일로 관리한다.
  ```dart
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
  ```
</details>

<details>
  <summary>1.6.3 Wrap up</summary>

  아래와 같은 형태로 네비게이션을 이용한다.

  ```dart
  navigation.push(
    context,
    AppRoute.settings.path,
    arguments: SettingsArguments(
      title: '설정',
      person: person,
    ),
  );
  ```
</details>