import 'package:telegram_proxy_api/telegram_proxy_api.dart';

Future<void> main() async {
  final api = TelegramProxyApiClient();
  final promt = await api.getMtprotos();
  final pros = await api.getsocksts();

  print(promt[0].uri.toString());
  print(pros[0].uri.toString());
}
