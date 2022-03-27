import 'package:telegram_proxy_api/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('mtproto model', () {
    Mtproto createSubject({
      String unix = '1600000000',
      String ip = 'tgram.club',
      String port = '443',
      String country = 'US',
      String ping = '20',
      String secret = 'ee...',
      String up = '120',
      String down = '0',
      String uptime = '100',
    }) {
      return Mtproto(
        unix: unix,
        port: port,
        country: country,
        ping: ping,
        host: ip,
        secret: secret,
        up: up,
        down: down,
        uptime: uptime,
      );
    }

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
            'tgram.club',
            '443',
            'US',
            '20',
            'ee...',
            '120',
            '0',
            '100',
          ]),
        );
      });
    });

    group('copy with', () {
      test('same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('return old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(country: null, secret: null, up: null),
          equals(createSubject()),
        );
      });

      test('replace every non-null paramter', () {
        expect(
          createSubject().copyWith(country: 'IR', ip: 't.me', uptime: '120'),
          equals(createSubject(country: 'IR', ip: 't.me', uptime: '120')),
        );
      });
    });

    group('fromJson', () {
      test('works fine', () {
        expect(
            Mtproto.fromJson({
              "unix": '1600000000',
              "host": 'tgram.club',
              "port": '443',
              "country": 'US',
              "ping": '20',
              "secret": 'ee...',
              "up": '120',
              "down": '0',
              "uptime": '100',
            }),
            equals(createSubject()));
      });
    });

    group('toJson', () {
      test('works fine', () {
        expect(
            createSubject().toJson(),
            equals({
              "unix": '1600000000',
              "host": 'tgram.club',
              "port": '443',
              "country": 'US',
              "ping": '20',
              "secret": 'ee...',
              "up": '120',
              "down": '0',
              "uptime": '100',
            }));
      });
    });

    group('launchUrl', () {
      test('should return valid launchUrl', () {
        expect(
          createSubject().launchUrl.toString(),
          equals('tg://proxy?server=tgram.club&port=443&secret=ee...'),
        );
      });
    });
  });
}
