import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/views/home_view.dart';

///
class NavigatorService {
  ///
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

///
class App extends StatelessWidget {
  /// Creates a new instance of [App].
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: NavigatorService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Widgetbook Interview Challenge',
        home: const HomeView(),
        theme: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(),
        ),
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(),
        ),
      );
}
