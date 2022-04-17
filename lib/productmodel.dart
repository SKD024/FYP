class ProductModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? postemail;

  ProductModel({this.id, this.title, this.description, this.image, this.postemail});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    postemail = json['postemail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['postemail'] = this.postemail;
    return data;
  }
}