import 'dart:io';

import 'package:args/args.dart';

class ServerParams {
  String _hostname;
  String get hostname => _hostname;

  int _port;
  int get port => _port;

  String _root;
  String get root => _root;

  String _logFile;
  String get logFile => _logFile;

  bool _listDir;
  bool get listDir => _listDir;

  bool _ssl;
  bool get ssl => _ssl;

  String _certificateChain;
  String get certificateChain => _certificateChain;

  String _serverKey;
  String get serverKey => _serverKey;

  String _serverKeyPassword;
  String get serverKeyPassword => _serverKeyPassword;

  ServerParams(List<String> args) {
    if (args != null) {
      createParamsFromArguments(args);
    }
  }

  void createParamsFromArguments(List<String> args) {
    var parser = ArgParser()
      ..addOption('host', abbr: 'h', defaultsTo: 'localhost')
      ..addOption('port', abbr: 'p', defaultsTo: '8080')
      ..addOption('root', abbr: 'r', defaultsTo: 'public')
      ..addOption('logFile', abbr: 'l', defaultsTo: null)
      ..addOption('listDir', abbr: 'd', defaultsTo: 'true')
      ..addOption('ssl', abbr: 's', defaultsTo: 'false')
      ..addOption('certificateChain', abbr: 'c', defaultsTo: null)
      ..addOption('serverKey', abbr: 'k', defaultsTo: null)
      ..addOption('serverKeyPassword', abbr: 'u', defaultsTo: null);
    var result = parser.parse(args);

    _hostname = result['host'];

    // For Google Cloud Run, we respect the PORT environment variable
    var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
    _port = int.tryParse(portStr);

    if (_port == null) {
      stdout.writeln('Could not parse port value "$portStr" into a number.');
      // 64: command line usage error
      exitCode = 64;
      exit(exitCode);
    }

    _root = result['root'];

    _logFile = result['logFile'];

    var listDirStr = result['listDir'];
    _listDir = listDirStr.toLowerCase() == 'true';

    var sslStr = result['ssl'];
    _ssl = sslStr.toLowerCase() == 'true';

    if (_ssl) {
      _certificateChain = result['certificateChain'];
      _serverKey = result['serverKey'];
      _serverKeyPassword = result['serverKeyPassword'];

      if (_certificateChain == null) {
        stdout.writeln('Could not find certificate chain.');
        // 64: command line usage error
        exitCode = 64;
        exit(exitCode);
      }

      if (_serverKey == null) {
        stdout.writeln('Could not find server key.');
        // 64: command line usage error
        exitCode = 64;
        exit(exitCode);
      }
    }
  }

  void printParams() {
    print('Hostname: ${_hostname.toString()}');
    print('Port: ${_port.toString()}');
    print('Root Dir: ${_root.toString()}');
    print('Log File: ${_logFile.toString()}');
    print('List Dir: ${_listDir.toString()}');

    print('SSL: ${_ssl.toString()}');
    print('Certificate Chain: ${_certificateChain.toString()}');
    print('Server Key: ${_serverKey.toString()}');
    print('Server Key Password: ${_serverKeyPassword.toString()}');
  }
}
