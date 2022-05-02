
class HashTagSearchResponseBean {
  String? id;
  String? name;
  String? created;
  String? userId;
  String? userInterests;
  String? contentHashtag;

  HashTagSearchResponseBean(
      {this.id,
        this.name,
        this.created,
        this.userId,
        this.userInterests,
        this.contentHashtag});

  HashTagSearchResponseBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created = json['created'];
    userId = json['userId'];
    userInterests = json['userInterests'];
    contentHashtag = json['contentHashtag'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['created'] = this.created;
    data['userId'] = this.userId;
    data['userInterests'] = this.userInterests;
    data['contentHashtag'] = this.contentHashtag;
    return data;
  }

  static List<HashTagSearchResponseBean> fromJsonList(dynamic jsonList) {
    var contentList = <HashTagSearchResponseBean>[];
    for (var item in jsonList) {
      contentList.add(HashTagSearchResponseBean.fromJson(item));
    }
    return contentList;
  }
}
