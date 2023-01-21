# flutter_navigation_sample

플러터 네비게이션 샘플입니다.

## 1. Built-in 네비게이션

### 목차

<ul>
  <li>1.1 네비게이션 사용</li>
  <li>1.2 기본적인 기능들 (push, pop, etc)</li>
  <li>1.3 복원 가능한 네비게이션</li>
  <li>1.4 변수 실어 보내기</li>
  <li>1.5 미비한 기능</li>
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
  <summary>Named route</summary>

  ```dart
  Navigator.of(context).pushNamed('settings');
  ```
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
  <summary>Named route</summary>

  ```dart
  Navigator.of(context).pushReplacementNamed('/$routeName', arguments: arguments);
  ```
  </details>
</details>


### 1.3 복원 가능한 네비게이션
