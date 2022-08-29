import 'dart:io';

import '../helpers/getIt.dart';
import 'params.dart';
import 'servers/rest.dart';
import 'servers/static.dart';

class FileHeronServer {
  final StaticServer _staticServer = StaticServer();
  final RestServer _restServer = RestServer();

  ServerParams _params;
  ServerParams get params => _params;

  // For future, we might have static as well as rest type server
  var _serverType = 'static';
  String get serverType => _serverType;

  void _init(List<String> args) {
    _params = ServerParams(args);
    if (_params.logFile != null) {
      setupGetIt(_params.logFile);
    }
  }

  void initStaticServer(List<String> args) {
    _init(args);
    _serverType = 'static';
    _staticServer.init(_params);
  }

  void _initRestServer(List<String> args) {
    _init(args);
    _serverType = 'rest';
    _restServer.init(_params);
  }

  void start() {
    if (_serverType == 'static') {
      _staticServer.start();
    } else if (_serverType == 'rest') {
      _restServer.start();
    } else {
      print('No other Server type supported yet!');
      exit(1);
    }
  }
}
