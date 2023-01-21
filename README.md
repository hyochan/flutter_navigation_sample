# flutter_navigation_sample

플러터 네비게이션 샘플입니다.

## 1. Built-in 네비게이션

### 목차

<ul>
  <li>1.1 네비게이션 사용</li>
  <li>1.2 기본적인 기능들 (push, pop, etc)</li>
  <li>1.3 복원 가능한 네비게이션</li>
  <li>1.4 변수 실어 보내기</li>
  <li>1.5 미비한 기능 (navigate)</li>
  <li>1.6 실사용 예제 (navigation.dart)</li>
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
<summary>push</summary>

  화면 이동시 사용. 스택으로 화면을 쌓음.

  ```dart
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const Settings(title: '설정'),
    ),
  );
  ```

  <details>
  <summary><span style="color: #47498A">Named route</span></summary>

  ```dart
  Navigator.of(context).pushNamed('settings', arguments: null);
  ```
  > Named route에서는 arguments를 보내기 위해서 특별히 `arguments` 파라미터를 제공함.
  </details>
</details>

<details>
<summary>pop</summary>

  뒤로가기. 현재 화면을 날림.

  ```dart
  Navigator.of(context).pop();
  ```
</details>

<details>
<summary>popUtil</summary>

  [React Navigation reset](https://reactnavigation.org/docs/navigation-prop/#reset)과 유사함.

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
<summary>pushReplacement</summary>

  화면 이동시 사용. 현재 화면을 비우고 넘어감. [React Navigation replace](https://reactnavigation.org/docs/stack-actions/#replace)와 유사함.

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
앱이 백그라운드에 가서 메모리 부족으로 앱에서 사용하는 메모리가 날라갔을 때 다시 foreground 상태에서 이전 state를 복원하는 기능을 제공함. 궁금하면 [해당 글](https://itnext.io/state-restoration-in-flutter-b6030b95a4d4)을 참고.

<details>
<summary>restorablePush</summary>

  화면 이동시 사용. 스택으로 화면을 쌓음.

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

  > `restorablePush`외에도 `restorablePushAndRemoveUntil`, `restorablePushNamed`, `restorablePushReplacement`, `restorablePushNamed` 등 기본 기능에 있는 모든 것들이 지원된다고 생각하면 된다. **Restorable**을 사용시 주의해야할 부분은 argument들이 `primitive` 타입이어야 함. 이는 **[React Navigation에서 권장하는 parameter]** 들과 동일.
</details>
