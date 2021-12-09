import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:riki_packages_tag/entitys/gitlab_tag_entity.dart';

part 'gitlab_client.g.dart';

@RestApi(baseUrl: 'https://gitlab.dabanjia.com/api/v4/')
abstract class GitlabClient{
  String? baseUrl;

  factory GitlabClient(Dio dio, {String baseUrl}) = _GitlabClient;

  @GET('projects/{id}/repository/tags')
  Future<List<GitlabTagEntity>> getTags(@Path("id") int projectId);
}