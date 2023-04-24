import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inware_task_app/model/product_model.dart';
import 'package:inware_task_app/screens/home_screen.dart';

class InfoProductScreen extends StatefulWidget {
  final ProductModel? product;

  const InfoProductScreen({this.product, super.key});

  @override
  State<InfoProductScreen> createState() => _InfoProductScreenState();
}

class _InfoProductScreenState extends State<InfoProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Info product'),
          centerTitle: true,
          leading: IconButton(
              iconSize: 25,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.file(
                File(widget.product!.imageUrl ?? ""),
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text(
                widget.product!.name!,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                widget.product!.type!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: Card(
                color: Colors.green[600],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "${widget.product!.cost} \$",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
