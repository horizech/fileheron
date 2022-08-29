import 'package:fileheron_server/fileheron_server.dart';

void main(List<String> args) async {
  var server = FileHeronServer();
  server.initStaticServer(ServerParams.fromArgs(args));
  server.start();
}
