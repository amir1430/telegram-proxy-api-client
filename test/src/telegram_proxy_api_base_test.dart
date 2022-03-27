import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:telegram_proxy_api/src/models/models.dart';
import 'package:telegram_proxy_api/src/telegram_proxy_api_base.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late TelegramProxyApiClient telegramProxyApiClient;
  late MockDio dio;

  setUp(() {
    dio = MockDio();
    telegramProxyApiClient = TelegramProxyApiClient(client: dio);
  });

  tearDown(() {
    dio.clear();
  });

  group('get mtproto', () {
    test('should throw [FetchRequestException] when non-200 response',
        () async {
      final response = MockResponse();

      when(() => response.statusCode).thenReturn(400);
      when(() => dio.get(any())).thenAnswer((_) async => response);

      await expectLater(telegramProxyApiClient.getMtprotos(),
          throwsA(isA<FetchRequestException>()));
    });

    group('on invalid response', () {
      test(
          'should throw [InvalidFetchDataException] when data is not [List<dynamic>]',
          () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({});
        when(() => dio.get(any())).thenAnswer((_) async => response);

        await expectLater(telegramProxyApiClient.getMtprotos(),
            throwsA(isA<InvalidFetchDataException>()));
      });

      test('should throw [JsonDeserializationException] when data in not valid json',
          () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn([
          {
            "uniix": 1600000000,
          }
        ]);
        when(() => dio.get(any())).thenAnswer((_) async => response);

        await expectLater(telegramProxyApiClient.getMtprotos(),
            throwsA(isA<JsonDeserializationException>()));
      });
    });

    test('should return [List<Mtproto>]', () async {
      final response = MockResponse();

      when(() => response.statusCode).thenReturn(200);
      when(() => response.data).thenReturn([
        {
          "unix": '1600000000',
          "host": 'tgram.club',
          "port": '443',
          "country": 'US',
          "ping": '20',
          "secret": 'ee...',
          "up": '120',
          "down": '0',
          "uptime": '100',
        }
      ]);
      when(() => dio.get(any())).thenAnswer((_) async => response);

      await expectLater(
        await telegramProxyApiClient.getMtprotos(),
        isA<List<Mtproto>>(),
      );
    });
  });
  group('get socks', () {
    test('should throw [FetchRequestException] when non-200 response',
        () async {
      final response = MockResponse();

      when(() => response.statusCode).thenReturn(400);
      when(() => dio.get(any())).thenAnswer((_) async => response);

      expect(() async => telegramProxyApiClient.getsocksts(),
          throwsA(isA<FetchRequestException>()));
    });
  });
}
