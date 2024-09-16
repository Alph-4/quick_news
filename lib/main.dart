import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/news.dart';
import 'package:quick_news/src/fondation/constants.dart';
import 'src/app.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  initHive();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox<NewModel>(newsBoxName);
  await Hive.openBox<NewModel>(mediaBoxName);
  Hive.registerAdapter(NewModelAdapter());
}
