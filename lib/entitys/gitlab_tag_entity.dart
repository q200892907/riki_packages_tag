import 'gitlab_tag_commit_entity.dart';

class GitlabTagEntity {
  GitlabTagEntity({
    this.name,
    this.message,
    this.target,
    this.commit,
    this.release,
  });

  GitlabTagEntity.fromJson(dynamic json) {
    name = json['name'];
    message = json['message'];
    target = json['target'];
    commit = json['commit'] != null ? GitlabTagCommitEntity.fromJson(json['commit']) : null;
    release = json['release'];
  }

  String? name;
  String? message;
  String? target;
  GitlabTagCommitEntity? commit;
  dynamic release;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['message'] = message;
    map['target'] = target;
    if (commit != null) {
      map['commit'] = commit?.toJson();
    }
    map['release'] = release;
    return map;
  }
}
