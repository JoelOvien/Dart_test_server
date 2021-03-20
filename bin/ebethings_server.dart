import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  final omoserver = await createServer();
  print(
      'Your server have start on: ${omoserver.address} port ${omoserver.port}');
  await handleRequests(omoserver);
}

Future<HttpServer> createServer() async {
  final address = InternetAddress.loopbackIPv4;
  const port = 7373;
  return await HttpServer.bind(address, port);
}

Future<void> handleRequests(HttpServer omoserver) async {
  await for (HttpRequest request in omoserver) {
    switch (request.method) {
      case 'GET':
        handleGetRequest(request);
        break;
      case 'POST':
        handlePostRequest(request);
        break;
      case 'PUT':
        handlePutRequest(request);
        break;
      default:
        handleDefault(request);
    }
  }
}

var bodyContainer = 'Heyo welcome to Ebethings Server';
// this gets updated with the post or put value entered last

void handleGetRequest(HttpRequest request) {
  request.response
    ..write(bodyContainer)
    ..close();
}

Future<void> handlePostRequest(HttpRequest request) async {
  bodyContainer = await utf8.decoder.bind(request).join();
  request.response
    ..write('Container Value stored')
    ..close();
}

Future<void> handlePutRequest(HttpRequest request) async {
  bodyContainer = await utf8.decoder.bind(request).join();
  request.response
    ..write('Server Value Updated')
    ..close();
}

void handleDefault(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.methodNotAllowed
    ..write('Ooopss Unsupported method: ${request.method}.')
    ..close();
}
