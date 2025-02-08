import 'package:dio/dio.dart';
import 'package:learn_api/cache/cash_helper.dart';
import 'package:learn_api/core/api/end_point.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.token] =
        CashHelper().getData(key: ApiKey.token) != null
            ? 'FOODAPI ${CashHelper().getData(key: ApiKey.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
