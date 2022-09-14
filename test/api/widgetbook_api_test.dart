import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';

import 'widgetbook_api_test.mocks.dart';

@GenerateMocks([WidgetbookApi])
void main() {
  late MockWidgetbookApi mockWidgetbookApi;

  setUpAll(() => {mockWidgetbookApi = MockWidgetbookApi()});

  group('Perform http requests', () {
    test('Request is successful and sends greeting message', () async {
      const expectedMessage = 'Hello Ethiel';

      when(
        mockWidgetbookApi.welcomeToWidgetbook(message: 'Ethiel'),
      ).thenAnswer((_) => Future.value('Hello Ethiel'));

      final result =
          await mockWidgetbookApi.welcomeToWidgetbook(message: 'Ethiel');

      expect(result, expectedMessage);
    });

    test('Request is unsuccessful and throws UnexpectedException', () async {
      // when(mockWidgetbookApi.randomNumberGenerator.nextInt(3)).thenReturn(9);
      when(
        mockWidgetbookApi.welcomeToWidgetbook(message: 'Ethiel'),
      ).thenAnswer((_) async {
        throw UnexpectedException();
      });

      final res = mockWidgetbookApi.welcomeToWidgetbook(message: 'Ethiel');

      expect(res, throwsException);
    });
  });
}
