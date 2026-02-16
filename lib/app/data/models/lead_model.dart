class LeadModel {
  int? id;
  int userId;
  String scrapType;
  String quantity;
  String price;
  String address;
  String city;
  String pincode;
  String imagePath;
  String createdAt;

  LeadModel({
    this.id,
    required this.userId,
    required this.scrapType,
    required this.quantity,
    required this.price,
    required this.address,
    required this.city,
    required this.pincode,
    required this.imagePath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "scrapType": scrapType,
      "quantity": quantity,
      "price": price,
      "address": address,
      "city": city,
      "pincode": pincode,
      "imagePath": imagePath,
      "createdAt": createdAt,
    };
  }

  factory LeadModel.fromMap(Map<String, dynamic> map) {
    return LeadModel(
      id: map["id"],
      userId: map["userId"],
      scrapType: map["scrapType"],
      quantity: map["quantity"],
      price: map["price"],
      address: map["address"],
      city: map["city"],
      pincode: map["pincode"],
      imagePath: map["imagePath"],
      createdAt: map["createdAt"],
    );
  }
}
