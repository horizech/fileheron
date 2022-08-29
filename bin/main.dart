import 'fileheron/server.dart';

void main(List<String> args) async {
  var server = FileHeronServer();
  server.initStaticServer(args);
  server.start();
}
