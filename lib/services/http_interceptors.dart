import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends InterceptorContract {
  Logger logger = Logger();

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    String requestBody = "";
    if (request is Request) {
      requestBody = request.body;
    }
    logger.t("Requisição para ${request.url} "
        "\nCabeçalhos: ${request.headers} "
        "\nCorpo: ${request.toString()}"
    );
    // print('----- Request -----');
    // print(request.toString());
    // print(request.headers.toString());
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    String responseBody = "";
    if (response is Response) {
      responseBody = response.body;
    }
    if(response.statusCode ~/ 100 == 2){
      logger.i("Resposta de ${response.request?.url} "
          "\nStatus da resposta: ${response.statusCode} - ${response.reasonPhrase}"
          "\nCabeçalhos: ${response.headers} "
          "\nCorpo: $responseBody"
      );
    } else {
      logger.e("Resposta de ${response.request?.url} "
          "\nStatus da resposta: ${response.statusCode} - ${response.reasonPhrase} "
          "\nCabeçalhos: ${response.headers} "
          "\nCorpo: $responseBody"
      );
    }

    // log('----- Response -----');
    // log('Code: ${response.statusCode}');
    // if (response is Response) {
    //   log((response).body);
    // }
    return response;
  }
}