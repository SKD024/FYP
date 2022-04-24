class UpcommingBooksModel {
  String? name;
  String? author;
  String? image;

  UpcommingBooksModel({this.name, this.author, this.image});

  UpcommingBooksModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    author = json['author'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['author'] = this.author;
    data['image'] = this.image;
    return data;
  }
}