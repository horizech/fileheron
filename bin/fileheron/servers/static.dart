import 'dart:io';

import 'package:http_server/http_server.dart';

import '../../helpers/getIt.dart';
import '../../services/log.dart';
import '../params.dart';

class StaticServer {
  VirtualDirectory _staticFiles;
  var _server;
  ServerParams _params;

  void init(ServerParams _params) {
    this._params = _params;
    _staticFiles = VirtualDirectory(_params.root);
    _staticFiles.allowDirectoryListing = true; /*1*/
    _staticFiles.directoryHandler = (dir, request) /*2*/ {
      var indexUri = Uri.file(dir.path).resolve('index.html');
      if (_params.listDir) {
        print('Sending: $indexUri');
      }
      _staticFiles.serveFile(File(indexUri.toFilePath()), request); /*3*/
    };
  }

  void start() async {
    try {
      if (_params.ssl) {
        var serverContext = SecurityContext();
        serverContext.useCertificateChain(_params.certificateChain);
        if (_params.serverKeyPassword != null) {
          serverContext.usePrivateKey(_params.serverKey,
              password: _params.serverKeyPassword);
        } else {
          serverContext.usePrivateKey(_params.serverKey);
        }
        _server = await HttpServer.bindSecure(
            _params.hostname, _params.port, serverContext);
      } else {
        _server = await HttpServer.bind(_params.hostname, _params.port);
      }
    } catch (e) {
      print(
          'Error occured while starting server. Make sure the parameters are valid!');
      // 64: command line usage error
      exitCode = 64;
      exit(exitCode);
    } finally {
      print(
          'Serving ${_params.root} at ${_params.ssl ? "https" : "http"}://${_server.address.host}:${_server.port}');
      await _server.forEach(await serveRequest); /*4*/

    }
  }

  void serveRequest(HttpRequest request) async {
    if (_params.listDir) {
      print('Sending: ${_params.root}${request.uri.toString()}');
    }

    if (_params.logFile != null) {
      getIt
          .get<LogService>()
          .log('Address: ${_params.root}${request.uri.toString()}');
    }

    await _staticFiles.serveRequest(request);
  }
}
