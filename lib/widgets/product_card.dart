import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:inware_task_app/model/product_model.dart';
import 'package:inware_task_app/screens/info_product/info_product.dart';

class ProductCard extends StatelessWidget {
  final ProductModel? product;
  final VoidCallback? onpressedDelete;
  final VoidCallback? onPressedEdit;
  const ProductCard(
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
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => InfoProductScreen(
                      product: product,
                    )));
          },
          child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff8d8d8d), offset: Offset(3.5, 3.5))
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.white),
              margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 90,
                      width: 90,
                      child: Image.file(
                        File(
                          product!.imageUrl ?? "",
                        ),
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!.name!,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          product!.type!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              product!.number!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2e2e2e)),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              product!.count!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2e2e2e)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: Colors.green[600],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Center(
                              child: Text(
                                "${product!.cost} \$",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
