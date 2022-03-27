import 'package:dio/dio.dart';
import 'package:telegram_proxy_api/telegram_proxy_api.dart';

class FetchRequestException implements Exception {}

class JsonDeserializationException implements Exception {}

class InvalidFetchDataException implements Exception {}

abstract class ITelegramProxyApiClient {
  Future<List<Mtproto>> getMtprotos();
  Future<List<Socks>> getsocksts();
}

class TelegramProxyApiClient implements ITelegramProxyApiClient {
  TelegramProxyApiClient({Dio? client})
      : _dioClient =
            client ?? Dio(BaseOptions(baseUrl: 'https://mtpro.xyz/api'));

  final Dio _dioClient;

  @override
  Future<List<Mtproto>> getMtprotos() async => await _fetchProxies<Mtproto>(
        parser: (e) => Mtproto.fromJson(e),
        type: ProxyType.mtproto,
      );

  @override
  Future<List<Socks>> getsocksts() async => await _fetchProxies<Socks>(
        parser: (e) => Socks.fromJson(e),
        type: ProxyType.socks,
      );

  Future<List<T>> _fetchProxies<T extends Socks>({
    required ProxyType type,
    required _MtprotoOrSocks<T> parser,
  }) async {
    late final Response response;

    try {
      response = await _dioClient.get('?type=${type.type}');
    } catch (e) {
      throw FetchRequestException();
    }

    if (response.statusCode != 200) {
      throw FetchRequestException();
    }

    if (response.data is! List<dynamic>) {
      throw InvalidFetchDataException();
    }

    late final List<T> proxies;

    try {
      proxies = response.data.map<T>(parser).toList();
    } catch (e) {
      throw JsonDeserializationException();
    }
    return proxies;
  }
}

typedef _MtprotoOrSocks<T> = T Function(dynamic e);

enum ProxyType { socks, mtproto }

extension ProxyTypeX on ProxyType {
  String get type {
    switch (this) {
      case ProxyType.mtproto:
        return 'mtproto';
      case ProxyType.socks:
        return 'socks';
      default:
        return '';
    }
  }
}
