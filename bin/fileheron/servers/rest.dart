import 'dart:io';

import '../../helpers/getIt.dart';
import '../params.dart';
import '../../services/log.dart';

class RestServer {
  var _server;
  ServerParams _params;

  void init(ServerParams _params) {
    this._params = _params;
  }

  void start() async {
    try {
      _server = await HttpServer.bind(_params.hostname, _params.port);
    } catch (e) {
      print(
          'Error occured while starting server. Make sure the parameters are valid!');
      // 64: command line usage error
      exitCode = 64;
      exit(exitCode);
    } finally {
      print(
          'Serving ${_params.root} at http://${_server.address.host}:${_server.port}');
      await for (HttpRequest request in _server) {
        await serveRequest(request);
      }
    }
  }

  void serveRequest(HttpRequest request) async {
    if (_params.listDir) {
      print('Serving | Method: ${request.method} | Path: ${request.uri.path}');
    }

    if (_params.logFile != null) {
      getIt
          .get<LogService>()
          .log('Method: ${request.method} | Path: ${request.uri.path}');
    }

    var response = request.response;
    response.write('Hello, world!');
    // response.statusCode = HttpStatus.ok;
    await response.close();
  }
}
