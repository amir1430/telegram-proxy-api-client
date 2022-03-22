import 'package:dio/dio.dart';
import 'package:telegram_proxy_api/telegram_proxy_api.dart';

abstract class ITelegramProxyApiClient {
  Future<List<Mtproto>> getMtprotos();
  Future<List<Socks>> getsocksts();
}

class TelegramProxyApiClient extends ITelegramProxyApiClient {
  TelegramProxyApiClient({Dio? client})
      : _dioClient =
            client ?? Dio(BaseOptions(baseUrl: 'https://mtpro.xyz/api'));

  final Dio _dioClient;

  @override
  Future<List<Mtproto>> getMtprotos() async {
    final proxies = await _fetchProxies('mtproto');
    try {
      return proxies.map((e) => Mtproto.fromJson(e)).toList();
    } catch (e) {
      throw JsonDeserializationException();
    }
  }

  @override
  Future<List<Socks>> getsocksts() async {
    final proxies = await _fetchProxies('socks');
    try {
      return proxies.map((e) => Socks.fromJson(e)).toList();
    } catch (e) {
      throw JsonDeserializationException();
    }
  }

  Future<List<dynamic>> _fetchProxies(String type) async {
    try {
      final res = await _dioClient.get('?type=$type');
      return res.data as List<dynamic>;
    } catch (e) {
      throw FetchRequestException();
    }
  }
}

class FetchRequestException implements Exception {}

class JsonDeserializationException implements Exception {}
