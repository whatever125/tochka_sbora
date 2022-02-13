class UserModel {
  String phoneNumber;
  String name;
  String surname;
  String secondName;
  bool isAdmin;
  int coins;
  int cardboard;
  int wastepaper;
  int glass;
  int plasticLids;
  int aluminiumCans;
  int plasticBottles;
  int plasticMK2;
  int plasticMK5;
  int plasticMK6;
  int plasticBags;
  int steel;
  List<Map<String, dynamic>> cart;

  UserModel({
    this.phoneNumber = '',
    this.name = '',
    this.surname = '',
    this.secondName = '',
    this.isAdmin = false,
    this.coins = 0,
    this.cardboard = 0,
    this.wastepaper = 0,
    this.glass = 0,
    this.plasticLids = 0,
    this.aluminiumCans = 0,
    this.plasticBottles = 0,
    this.plasticMK2 = 0,
    this.plasticMK5 = 0,
    this.plasticMK6 = 0,
    this.plasticBags = 0,
    this.steel = 0,
    this.cart = const [],
  });

  void fromJson(Map<String, dynamic> json) {
    this.phoneNumber = json['phoneNumber'];
    this.name = json['name'];
    this.surname = json['surname'];
    this.secondName = json['secondName'];
    this.isAdmin = json['isAdmin'];
    this.coins = json['coins'];
    this.cardboard = json['cardboard'];
    this.wastepaper = json['wastepaper'];
    this.glass = json['glass'];
    this.plasticLids = json['plasticLids'];
    this.aluminiumCans = json['aluminiumCans'];
    this.plasticBottles = json['plasticBottles'];
    this.plasticMK2 = json['plasticMK2'];
    this.plasticMK5 = json['plasticMK5'];
    this.plasticMK6 = json['plasticMK6'];
    this.plasticBags = json['plasticBags'];
    this.steel = json['steel'];
    this.cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': this.phoneNumber,
      'name': this.name,
      'surname': this.surname,
      'secondName': this.secondName,
      'isAdmin': this.isAdmin,
      'coins': this.coins,
      'cardboard': this.cardboard,
      'wastepaper': this.wastepaper,
      'glass': this.glass,
      'plasticLids': this.plasticLids,
      'aluminiumCans': this.aluminiumCans,
      'plasticBottles': this.plasticBottles,
      'plasticMK2': this.plasticMK2,
      'plasticMK5': this.plasticMK5,
      'plasticMK6': this.plasticMK6,
      'plasticBags': this.plasticBags,
      'steel': this.steel,
      'cart': this.cart,
    };
  }
}
