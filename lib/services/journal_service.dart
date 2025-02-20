import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:journal/services/http_interceptors.dart';

import '../models/journal.dart';

http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()]
);

class JournalService {
  //variaveis que nao vao mudar em tempo de execucao --> static
  static const String url = "http://192.168.31.126:3000/";
  static const String resource = "journals";

  String getUrl() {
    return "$url$resource";
  }

Future<bool> register(Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());
    http.Response response = await client.post(
        Uri.parse(getUrl()),
        headers: {'Content-type': 'application/json'},
        body: jsonJournal
    );
    if(response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    print(response.body);
    return response.body;
  }
}
