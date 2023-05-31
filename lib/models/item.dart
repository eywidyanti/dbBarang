class Item {
  late int _id;
  late String name;
  late int price;
  late String kode;
  late int stok;

  int get id => _id;
  set id(int id) {
    _id = id;
  }

  Item(
      {required this.name,
      required this.price,
      required this.kode,
      required this.stok});

  Item.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    name = map['name'];
    price = map['price'];
    kode = map['kode'];
    stok = map['stok'];
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'kode': kode, 'stok': stok};
  }
}
