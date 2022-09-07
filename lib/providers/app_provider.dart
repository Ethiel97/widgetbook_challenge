import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';
import 'package:widgetbook_challenge/extensions/snack_extension.dart';

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

      context.showSnack('Please wait...');

      apiResponse = await WidgetbookApi().welcomeToWidgetbook(message: name);
      notifyListeners();

      return Success(apiResponse);
    } catch (e) {
      context.showSnack(
        'Please try again',
        backgroundColor: Theme.of(context).errorColor,
        textColor: Theme.of(context).colorScheme.onError,
      );
      return Error(UnexpectedException());
    } finally {
      appStatus = AppStatus.finished;
      notifyListeners();
    }
  }
}
