import 'package:flutter/material.dart';
import 'package:goodplays/models/network_manager.dart';
import 'package:goodplays/models/utils.dart';

class ServiceLocator extends InheritedWidget {
  ServiceLocator({
    Key? key,
    required this.child,
  }) : super(key: key, child: child);

  static NetworkBloc networkBloc = new NetworkBloc();
  static Utils utils = new Utils();
  final Widget child;

  static ServiceLocator? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ServiceLocator>();
  }

  @override
  bool updateShouldNotify(ServiceLocator oldWidget) {
    return true;
  }
}
