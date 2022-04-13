class NotificationModel {
  int? id;
  String? title;
  String? description;
  Null? image;
  bool? isAccepted;
  String? requestUserId;
  String? postUserId;
  String? requestEmail;
  String? postEmail;

  NotificationModel(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.isAccepted,
        this.requestUserId,
        this.postUserId,
        this.requestEmail,
        this.postEmail});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    isAccepted = json['isAccepted'];
    requestUserId = json['requestUserId'];
    postUserId = json['postUserId'];
    requestEmail = json['requestEmail'];
    postEmail = json['postEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['isAccepted'] = this.isAccepted;
    data['requestUserId'] = this.requestUserId;
    data['postUserId'] = this.postUserId;
    data['requestEmail'] = this.requestEmail;
    data['postEmail'] = this.postEmail;
    return data;
  }
}