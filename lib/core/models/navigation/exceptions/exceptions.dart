class ServerError implements Exception {}

class NetworkError implements Exception {}

class BadCredentialsError implements Exception {}

class DioErrors {
  static const SOCKET_EXCEPTION = "SocketException: Failed host lookup";
}
