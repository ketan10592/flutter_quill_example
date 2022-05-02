class AtMentionSearchResponseBean {
  String? id;
  String? uid;
  String? firstName;
  String? userName;
  String? lastName;
  String? fullName;
  String? pictureLink;

  AtMentionSearchResponseBean(
      {this.id,
        this.uid,
        this.firstName,
        this.userName,
        this.lastName,
        this.fullName,
        this.pictureLink});

  AtMentionSearchResponseBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    firstName = json['firstName'];
    userName = json['userName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    pictureLink = json['pictureLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['firstName'] = this.firstName;
    data['userName'] = this.userName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['pictureLink'] = this.pictureLink;
    return data;
  }

  static List<AtMentionSearchResponseBean> fromJsonList(dynamic jsonList) {
    var contentList = <AtMentionSearchResponseBean>[];
    for (var item in jsonList) {
      contentList.add(AtMentionSearchResponseBean.fromJson(item));
    }
    return contentList;
  }
}
