import 'dart:io';

import 'package:dio/dio.dart';

const baseUrl = String.fromEnvironment('baseUrl');

enum AccessCondition {
  good,
  error,
  networkError,
}

class NetworkModel {
  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 60),
    responseType: ResponseType.json,
    contentType: 'application/json',
  ));

  Future<Map<AccessCondition, dynamic>> getMeal(
    String apiEndpoint,
  ) async {
    try {
      final networkResponse = await isNetworkAvailable();
      if (networkResponse == false) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      }
      final response = await dio.get(
        baseUrl + apiEndpoint,
      );
      return {AccessCondition.good: response.data};
    } on DioException catch (err) {
      if (err.type == DioExceptionType.connectionError) {
        return {
          AccessCondition.networkError: 'Unable to Connect to the network'
        };
      } else {
        return {
          AccessCondition.error: 'Error Retrieving data from server',
        };
      }
    } catch (e) {
      return {
        AccessCondition.error: e.toString(),
      };
    }
  }
}

Future<bool> isNetworkAvailable() async {
  try {
    final response = await InternetAddress.lookup('google.com');
    return response.isNotEmpty && response[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}
