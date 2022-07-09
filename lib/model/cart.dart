class Cart {
  String? cartid;
  String? subname;

  String? price;
  String? cartqty;
  String? subid;
  String? pricetotal;

  Cart(
      {this.cartid,
      this.subname,
    
      this.price,
      this.cartqty,
      this.subid,
      this.pricetotal});

  Cart.fromJson(Map<String, dynamic> json) {
    cartid = json['cartid'];
  subname = json['subname'];
  
    price = json['price'];
    cartqty = json['cartqty'];
    subid= json['subid'];
    pricetotal = json['pricetotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartid'] = cartid;
    data['subname'] = subname;
   
    data['price'] = price;
    data['cartqty'] = cartqty;
    data['subid'] = subid;
    data['pricetotal'] = pricetotal;
    return data;
  }
} 