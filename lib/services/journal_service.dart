import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:journal/services/http_interceptors.dart';

http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()]
);

class JournalService {
  //variaveis que nao vao mudar em tempo de execucao --> static
  static const String url = "http://192.168.31.126:3000/";
  static const String resource = "learnhttp";

  String getUrl() {
    return "$url$resource";
  }

  register(String content) async {
    Map<String, String> data = {"content": content};
    String jsonData = json.encode(data);
    var response = await client.post(
      Uri.parse(getUrl()),
      headers: {
        'Content-Type':
            'application/json', // Tell the server we're sending JSON
      },
      body: jsonData,
    );
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    print(response.body);
    return response.body;
  }
}
