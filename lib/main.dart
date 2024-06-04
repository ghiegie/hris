import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/model/app_model.dart';
import 'package:hris/start.dart';
import 'package:window_manager/window_manager.dart';

final appModel = ChangeNotifierProvider<AppModel>((ref) => AppModel());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal
  );

  windowManager.waitUntilReadyToShow(windowOptions, _waitUntilreadyToShowTasks);

  runApp(const ProviderScope(
    child: App()
  ));
}

void _waitUntilreadyToShowTasks() async {
  await windowManager.setTitle("HRIS");
  await windowManager.setResizable(false);
  await windowManager.show();
  await windowManager.focus();
  await windowManager.setMaximizable(false);
}