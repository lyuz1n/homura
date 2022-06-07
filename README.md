## Adding in pubspec.yaml

TODO: This package has not yet been published on pub.dev (maybe in the future)

```yaml
# cupertino_icons: ^1.0.2
  homura:
    git:
      url: https://github.com/lyuz1n/homura.git
```

## Import

```dart
import 'package:homura/homura.dart';
```

## Injecting permanent controllers like Provider

TODO: Reccomended path `src/app/app_controllers.dart`

```dart
abstract class AppControllers {
  static void init() {
    Homura.put(AppController());
    // Homura.put(OtherExampleController());
  }
}
```

## Calling the AppControllers init method in main

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppControllers.init();

  runApp(const App());
}
```

## Counter App Example

```dart
class AppController extends HomuraController {
  int count = 0;

  void increment() {
    count++;
    update();
  }
}

class AppView extends HomuraView<AppController> {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HBuilder(
          () => Text('counter: ${controller.count}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: controller.increment,
      ),
    );
  }
}
```
