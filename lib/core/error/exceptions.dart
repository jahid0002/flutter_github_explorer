/// Custom exception for server-related errors
class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Server error occurred']);

  @override
  String toString() => 'ServerException: $message';
}

/// Custom exception for cache-related errors
class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error occurred']);

  @override
  String toString() => 'CacheException: $message';
}

/// Custom exception for network-related errors
class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'Network error occurred']);

  @override
  String toString() => 'NetworkException: $message';
}
