class Drink {
  String? thname;
  int? price;
  bool? checked;

  //Constructor
  Drink(this.thname, this.price, this.checked);

  static getDrink() {
    return [
      Drink('คาปูชิโน่', 99, true),
      Drink('ลาเต้', 79, false),
      Drink('อเมริกาโน่', 89, false),
      Drink('แบล็คคอฟฟี่', 69, false),
    ];
  }
}
