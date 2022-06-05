import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Homura {
  static final Map<Type, ChangeNotifier> _controllers = {};

  static T put<T extends ChangeNotifier>(T controller, {bool replaceOld = false}) {
    final Type type = controller.runtimeType;

    bool oldRemoved = false;
    if (replaceOld && _controllers[type] != null) {
      oldRemoved = _controllers.remove(type) != null;
    }

    if (_controllers[type] == null) {
      _controllers[type] = controller;
      if (kDebugMode) {
        print('[Homura]: $type ${oldRemoved ? 'replaced' : 'initialized'}.');
      }
    }
    return controller;
  }

  static void _delete(Type controllerType) {
    if (_controllers[controllerType] != null && _controllers.remove(controllerType) != null) {
      if (kDebugMode) {
        print('[Homura]: $controllerType deleted.');
      }
    }
  }

  static T get<T extends ChangeNotifier>() {
    if (_controllers[T] != null) return _controllers[T] as T;

    throw '[Homura]: Cannot find $T! Needs to initialize with "Homura.put($T());"';
  }
}

abstract class HomuraController extends ChangeNotifier {
  void update() => notifyListeners();

  void delete() {
    Homura._delete(runtimeType);
  }
}

abstract class HomuraView<T extends ChangeNotifier> extends StatelessWidget {
  const HomuraView({Key? key}) : super(key: key);

  T get controller => Homura.get<T>();

  // ignore: non_constant_identifier_names
  Widget HBuilder(Widget Function() builder) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => builder.call(),
    );
  }
}

class HomuraBuilder<T extends ChangeNotifier> extends HomuraView<T> {
  const HomuraBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function() builder;

  @override
  Widget build(BuildContext context) => HBuilder(builder);
}
