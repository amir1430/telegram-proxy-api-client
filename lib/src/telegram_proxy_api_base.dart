import 'package:dio/dio.dart';
import 'package:telegram_proxy_api/telegram_proxy_api.dart';

class FetchRequestException implements Exception {}

class JsonDeserializationException implements Exception {}

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
  Future<List<Mtproto>> getMtprotos() async =>
      await _getMtprotoOrSocks<Mtproto>(
        parser: (e) => Mtproto.fromJson(e),
        type: ProxyType.mtproto,
      );

  @override
  Future<List<Socks>> getsocksts() async => await _getMtprotoOrSocks<Socks>(
        parser: (e) => Socks.fromJson(e),
        type: ProxyType.socks,
      );

  Future<List<T>> _getMtprotoOrSocks<T extends Socks>({
    required _MtprotoOrSocks<T> parser,
    required ProxyType type,
  }) async {
    final proxies = await _fetchProxies(type);
    try {
      return proxies.map<T>(parser).toList();
    } catch (e) {
      throw JsonDeserializationException();
    }
  }

  Future<List<dynamic>> _fetchProxies(ProxyType type) async {
    try {
      final res = await _dioClient.get('?type=${type.type}');
      return res.data as List<dynamic>;
    } catch (e) {
      throw FetchRequestException();
    }
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
