class ProductModel {
  int? id;
  String? title;
  String? description;

  ProductModel({this.id, this.title, this.description});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
