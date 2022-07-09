class User {
  String? id;
  String? name;
  String? email;
  
  String? phone;
 String? address;
  String? datereg;
    String? cart;


  User(
      {this.id,
       this.name,
      this.email,

       this.phone,
       this.address,
      this.datereg,
   this.cart
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  
   phone = json['phone'];
    address = json['address'];
   datereg = json['datereg'];
        cart = json['cart'].toString();


  }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['datereg'] = datereg;
     data['address'] = address;
       data['cart'] = cart.toString();

    return data;
  }
}