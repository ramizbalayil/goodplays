import 'package:flutter/material.dart';
import 'package:goodplays/models/notifiers.dart';

class ServiceLocator extends InheritedWidget {
  ServiceLocator({Key? key, required this.child, required this.networkBloc})
      : super(key: key, child: child);

  final NetworkBloc networkBloc;
  final Widget child;

  static ServiceLocator? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ServiceLocator>();
  }

  @override
  bool updateShouldNotify(ServiceLocator oldWidget) {
    return true;
  }
}
