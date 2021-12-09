// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gitlab_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GitlabClient implements GitlabClient {
  _GitlabClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://gitlab.dabanjia.com/api/v4/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<GitlabTagEntity>> getTags(projectId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<GitlabTagEntity>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'projects/$projectId/repository/tags',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => GitlabTagEntity.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
