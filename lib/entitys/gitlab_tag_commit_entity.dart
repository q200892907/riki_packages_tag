class GitlabTagCommitEntity {
  GitlabTagCommitEntity({
    this.id,
    this.shortId,
    this.title,
    this.createdAt,
    this.parentIds,
    this.message,
    this.authorName,
    this.authorEmail,
    this.authoredDate,
    this.committerName,
    this.committerEmail,
    this.committedDate,
  });

  GitlabTagCommitEntity.fromJson(dynamic json) {
    id = json['id'];
    shortId = json['short_id'];
    title = json['title'];
    createdAt = json['created_at'];
    parentIds = json['parent_ids'] != null ? json['parent_ids'].cast<String>() : [];
    message = json['message'];
    authorName = json['author_name'];
    authorEmail = json['author_email'];
    authoredDate = json['authored_date'];
    committerName = json['committer_name'];
    committerEmail = json['committer_email'];
    committedDate = json['committed_date'];
  }

  String? id;
  String? shortId;
  String? title;
  String? createdAt;
  List<String>? parentIds;
  String? message;
  String? authorName;
  String? authorEmail;
  String? authoredDate;
  String? committerName;
  String? committerEmail;
  String? committedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['short_id'] = shortId;
    map['title'] = title;
    map['created_at'] = createdAt;
    map['parent_ids'] = parentIds;
    map['message'] = message;
    map['author_name'] = authorName;
    map['author_email'] = authorEmail;
    map['authored_date'] = authoredDate;
    map['committer_name'] = committerName;
    map['committer_email'] = committerEmail;
    map['committed_date'] = committedDate;
    return map;
  }
}
