import 'package:telegram_proxy_api/telegram_proxy_api.dart';

Future<void> malaunchUrlin() async {
  final api = TelegramProxyApiClient();
  final promt = await api.getMtprotos();
  final pros = await api.getsocksts();

  print(promt[0].launchUrl.toString());
  print(pros[0].launchUrl.toString());
}
