import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class Message {
  String get type;

  Map<String, dynamic> getData();
  Map<String, dynamic> toJson() => {"type": this.type, "data": getData()};
  Future<void> send(LedClient client) => client.sendMessage(this);
}

abstract class Pattern extends Message {
  String get type => "pattern";
  String get name;

  Map<String, dynamic> getArgs();
  Map<String, dynamic> getData() => {"pattern": name, ...getArgs()};
}

class LedException implements Exception {
  String message;
  int status;

  LedException(this.message, this.status) : super();
}

class LedClient {
  LedClient(this._baseUrl, {http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final String _baseUrl;

  Future<void> sendMessage(Message message) async {
    final ledRequest = Uri.parse(_baseUrl + "/api/pattern");

    final response = await _httpClient.post(ledRequest, body: jsonEncode(message.toJson()));

    if (response.statusCode != 200) {
      throw LedException(response.body, response.statusCode);
    }
  }
}
