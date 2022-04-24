class Users {
  String? name;
  String? email;
  String? address;
  String? phonenumber;

  Users({this.name, this.email, this.address, this.phonenumber});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phonenumber = json['phonenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phonenumber'] = this.phonenumber;
    return data;
  }
}