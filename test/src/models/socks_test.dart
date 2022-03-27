import 'package:telegram_proxy_api/telegram_proxy_api.dart';
import 'package:test/test.dart';

void main() {
  group('Socks model', () {
    Socks createSubject({
      String unix = '1600000000',
      String ip = '1.1.1.1',
      String port = '1080',
      String country = 'US',
      String ping = '20',
    }) =>
        Socks(
          unix: unix,
          ip: ip,
          port: port,
          country: country,
          ping: ping,
        );

    group('constructor', () {
      test('return normaly', () {
        expect(createSubject, returnsNormally);
      });
      test('equality check', () {
        expect(createSubject(), equals(createSubject()));
      });
      test('description', () {
        expect(
          createSubject().props,
          equals([
            '1600000000',
            '1.1.1.1',
            '1080',
            'US',
            '20',
          ]),
        );
      });
    });

    group('Copy with', () {
      test('same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('return old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            country: null,
            ip: null,
            ping: null,
            port: null,
            unix: null,
          ),
          equals(createSubject()),
        );
      });

      test('replace every non-null paramter', () {
        expect(
          createSubject().copyWith(country: 'IR', ip: '192,168.1.1'),
          equals(createSubject(country: 'IR', ip: '192,168.1.1')),
        );
      });
    });

    group('fromJson', () {
      test('works fine', () {
        expect(
          Socks.fromJson({
            'unix': '1600000000',
            'ip': '1.1.1.1',
            'port': '1080',
            'country': 'US',
            'ping': '20',
          }),
          equals(createSubject()),
        );
      });
    });

    group('toJson', () {
      test('wokrs fine', () {
        expect(
          createSubject().toJson(),
          equals({
            'unix': '1600000000',
            'ip': '1.1.1.1',
            'port': '1080',
            'country': 'US',
            'ping': '20',
          }),
        );
      });
    });

    group('launchUrl', () {
      test('should return valid launchUrl', () {
        expect(
          createSubject().launchUrl.toString(),
          equals('tg://socks?server=1.1.1.1&port=1080'),
        );
      });
    });
  });
}
