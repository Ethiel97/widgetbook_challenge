import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook_challenge/app.dart';
import 'package:widgetbook_challenge/providers/app_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const App(),
    ),
  );
}
