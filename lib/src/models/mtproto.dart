import 'package:telegram_proxy_api/telegram_proxy_api.dart';

class Mtproto extends Socks {
  const Mtproto({
    required String unix,
    required String port,
    required String country,
    required String ping,
    required String host,
    required this.secret,
    required this.up,
    required this.down,
    required this.uptime,
  }) : super(unix: unix, ip: host, port: port, country: country, ping: ping);

  final String secret;
  final String up;
  final String down;
  final String uptime;

  @override
  Mtproto copyWith({
    String? unix,
    String? ip,
    String? port,
    String? country,
    String? ping,
    String? secret,
    String? up,
    String? down,
    String? uptime,
  }) {
    return Mtproto(
      unix: unix ?? this.unix,
      port: port ?? this.port,
      country: country ?? this.country,
      ping: ping ?? this.ping,
      host: ip ?? this.ip,
      secret: secret ?? this.secret,
      up: up ?? this.up,
      down: down ?? this.down,
      uptime: uptime ?? this.uptime,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "unix": unix,
      "port": port,
      "country": country,
      "ping": ping,
      "host": ip,
      "secret": secret,
      "up": up,
      "down": down,
      "uptime": uptime,
    };
  }

  factory Mtproto.fromJson(Map<String, dynamic> json) {
    return Mtproto(
      unix: json['unix'] as String,
      host: json['host'] as String,
      port: json['port'] as String,
      country: json['country'] as String,
      ping: json['ping'] as String,
      secret: json['secret'] as String,
      up: json['up'] as String,
      down: json['down'] as String,
      uptime: json['uptime'] as String,
    );
  }

  @override
  Uri get launchUrl => super.launchUrl.replace(
      host: 'proxy',
      queryParameters: {...super.launchUrl.queryParameters, "secret": secret});

  @override
  List<Object?> get props => [...super.props, secret, up, down, uptime];
}
