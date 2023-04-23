import 'package:flutter/material.dart';
import 'package:inware_task_app/model/product_model.dart';

class SearchCard extends StatelessWidget {
  final ProductModel? product;
  final VoidCallback? onpressed;
  const SearchCard({this.product, this.onpressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpressed,
      title: Text(
        product!.name!,
        style: const TextStyle(fontSize: 20, color: Colors.blue),
      ),
      subtitle: Text(product!.type!),
      trailing: Text(
        product!.cost!,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green[500]),
      ),
    );
  }
}
