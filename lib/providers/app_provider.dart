import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';

/// status of the app
enum AppStatus {
  ///initialized status
  initialized,

  ///processing status
  processing,

  ///finished status
  finished
}

///
class AppProvider with ChangeNotifier {
  /// initialize app status
  AppStatus appStatus = AppStatus.initialized;

  /// response from the widgetbook api
  String apiResponse = '';

  /// function to handle form submission
  Future<Result<Exception, String>> submitForm(
    String name,
    BuildContext context,
  ) async {
    try {
      appStatus = AppStatus.processing;
      notifyListeners();

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(
              seconds: 2,
            ),
            content: Text(
              'Processing',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      apiResponse = await WidgetbookApi().welcomeToWidgetbook(message: name);
      notifyListeners();

      return Success(apiResponse);
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(
              seconds: 2,
            ),
            content: Text(
              'Please try again',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      return Error(UnexpectedException());
    } finally {
      appStatus = AppStatus.finished;
      notifyListeners();
    }
  }
}
