import 'package:equatable/equatable.dart';

class Socks extends Equatable {
  const Socks({
    required this.unix,
    required this.ip,
    required this.port,
    required this.country,
    required this.ping,
  });

  final String unix;
  final String ip;
  final String port;
  final String country;
  final String ping;

  Socks copyWith({
    String? unix,
    String? ip,
    String? port,
    String? country,
    String? ping,
  }) {
    return Socks(
      unix: unix ?? this.unix,
      ip: ip ?? this.ip,
      port: port ?? this.port,
      country: country ?? this.country,
      ping: ping ?? this.ping,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unix': unix,
      'ip': ip,
      'port': port,
      'country': country,
      'ping': ping,
    };
  }

  factory Socks.fromJson(Map<String, dynamic> json) {
    return Socks(
      unix: json['unix'] as String,
      ip: json['ip'] as String,
      port: json['port'] as String,
      country: json['country'] as String,
      ping: json['ping'] as String,
    );
  }

  Uri get launchUrl => Uri(
      scheme: 'tg',
      host: 'socks',
      queryParameters: {"server": ip, "port": port});

  @override
  List<Object?> get props => [unix, ip, port, country, ping];

  @override
  bool? get stringify => true;
}
