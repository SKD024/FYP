class NotificationModel {
  int? id;
  String? title;
  String? description;
  bool? isAccepted;
  String? requestUserId;
  String? postUserId;
  String? requestEmail;
  String? postEmail;
  String? genre;
  String? author;
  String? price;
  String? condition;

  NotificationModel(
      {this.id,
        this.title,
        this.description,
        this.isAccepted,
        this.requestUserId,
        this.postUserId,
        this.requestEmail,
        this.postEmail,
        this.genre,
        this.author,
        this.price,
        this.condition});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isAccepted = json['isAccepted'];
    requestUserId = json['requestUserId'];
    postUserId = json['postUserId'];
    requestEmail = json['requestEmail'];
    postEmail = json['postEmail'];
    genre = json['genre'];
    author = json['author'];
    price = json['price'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isAccepted'] = this.isAccepted;
    data['requestUserId'] = this.requestUserId;
    data['postUserId'] = this.postUserId;
    data['requestEmail'] = this.requestEmail;
    data['postEmail'] = this.postEmail;
    data['genre'] = this.genre;
    data['author'] = this.author;
    data['price'] = this.price;
    data['condition'] = this.condition;
    return data;
  }
}