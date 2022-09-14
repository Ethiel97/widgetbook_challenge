import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';
import 'package:widgetbook_challenge/app.dart';
import 'package:widgetbook_challenge/extensions/snack_extension.dart';

///this describes the different states
///that the application takes during its execution
enum AppStatus {
  ///initialized status
  initialized,

  ///processing status
  processing,

  ///finished status
  finished
}

///
/// a class to act as view model to handle interactions
/// and business logic
class AppProvider with ChangeNotifier {
  /// initialized app status
  /// this is the status of the app at the beginning
  ///
  AppStatus appStatus = AppStatus.initialized;

  /// response from the widgetbook api
  String apiResponse = '';

  /// A function to handle form submission
  /// and to perform request to the backend
  ///
  Future<void> submitForm(
    String name,
  ) async {
    try {
      appStatus = AppStatus.processing;
      notifyListeners();

      NavigatorService.navigatorKey.currentContext?.showSnack('Please wait...');

      apiResponse = await WidgetbookApi().welcomeToWidgetbook(message: name);
      notifyListeners();
    } catch (e) {
      NavigatorService.navigatorKey.currentContext?.showSnack(
        'Please try again',
        backgroundColor:
            Theme.of(NavigatorService.navigatorKey.currentContext!).errorColor,
        textColor: Theme.of(NavigatorService.navigatorKey.currentContext!)
            .colorScheme
            .onError,
      );
    } finally {
      appStatus = AppStatus.finished;
      notifyListeners();
    }
  }
}
