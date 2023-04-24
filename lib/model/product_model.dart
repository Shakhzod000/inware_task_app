class ProductModel {
  String? name;
  String? type;
  String? id;
  String? count;
  String? imageUrl;
  String? cost;

  ProductModel(
      {this.cost, this.imageUrl, this.count, this.id, this.name, this.type});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      cost: json['cost'],
      count: json['count'],
      imageUrl: json['imageUrl'],
      id: json['id'],
      name: json['name'],
      type: json['type']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'cost': cost,
        'imageUrl': imageUrl,
        'name': name,
        'count': count,
        'type': type
      };
}
