class ProductModel {
  String? name;
  String? type;
  int? id;
  String? count;
  String? cost;

  ProductModel({this.cost, this.count, this.id, this.name, this.type});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      cost: json['cost'],
      count: json['count'],
      id: json['id'],
      name: json['name'],
      type: json['type']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'cost': cost, 'name': name, 'count': count, 'type': type};
}
