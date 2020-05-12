class Favourite {
  int id;
  String _productPath;
  String _category;
  int _quantity;

  Favourite(this._productPath, this._category, this._quantity);

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  Favourite.map(dynamic obj) {
    this._productPath = obj["productPath"];
    this._category = obj["category"];
  }

  String get productPath => _productPath;

  String get category => _category;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["productPath"] = _productPath;
    map["category"] = _category;

    return map;
  }

  void setProductId(int id) {
    this.id = id;
  }
}
