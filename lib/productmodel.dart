class ProductModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? postemail;
  String? genre;
  String? author;
  String? price;
  String? condition;

  ProductModel(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.postemail,
        this.genre,
        this.author,
        this.price,
        this.condition});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    postemail = json['postemail'];
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
    data['image'] = this.image;
    data['postemail'] = this.postemail;
    data['genre'] = this.genre;
    data['author'] = this.author;
    data['price'] = this.price;
    data['condition'] = this.condition;
    return data;
  }
}