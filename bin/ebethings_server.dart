import 'dart:io';

Future<void> main() async {
  final omoserver = await createServer();
  print(
      'Your server have start on: ${omoserver.address} port ${omoserver.port}');
}

Future<HttpServer> createServer() async {
  final address = InternetAddress.loopbackIPv4;
  const port = 7777;
  return await HttpServer.bind(address, port);
}
