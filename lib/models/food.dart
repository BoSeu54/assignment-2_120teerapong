class Food {
  String? thname;
  String? engname;
  int? price;
  String? foodValue;

  //Constructor
  Food(this.thname, this.engname, this.price, this.foodValue);

  static getFood() {
    return [
      Food('พิซซ๋า', 'Pizza', 99, 'pizza'),
      Food('สเต็ก', 'Steak', 129, 'steak'),
      Food('ชาบู', 'Shabu', 399, 'shabu'),
      Food('ซูชิ', 'Shushi', 29, 'shushi'),
      Food('กิมจิ', 'Kimji', 59, 'kimji'),
    ];
  }
}
