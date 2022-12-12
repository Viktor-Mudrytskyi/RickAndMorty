import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo { 
  final InternetConnectionChecker connectionChecker;
  const NetworkInfoImpl({required this.connectionChecker});
  @override
  //TODO: connection troubles
  Future<bool> get isConnected async =>await connectionChecker.hasConnection; 
}
