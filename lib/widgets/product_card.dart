import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:inware_task_app/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel? product;
  final VoidCallback? onpressedDelete;
  final VoidCallback? onPressedEdit;
  const  ProductCard(
      {this.product, this.onPressedEdit, this.onpressedDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          Expanded(
              child: GestureDetector(
            onTap: onPressedEdit,
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.blue),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 30,
              ),
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: onpressedDelete,
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.red),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
            ),
          ))
        ]),
        child: Container(
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(color: Color(0xff8d8d8d), offset: Offset(3.5, 3.5))
            ], borderRadius: BorderRadius.circular(15), color: Colors.white),
            margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      product!.type!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        product!.name!,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[400]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 15),
                  child: Column(
                    children: [
                      Text(
                        product!.count!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${product!.cost} \$",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[300]),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            )));
  }
}
