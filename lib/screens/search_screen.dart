import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inware_task_app/db_helper/db_service.dart';
import 'package:inware_task_app/model/product_model.dart';
import 'package:inware_task_app/screens/home_screen.dart';
import 'package:inware_task_app/screens/info_product/info_product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                iconSize: 25,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text('AutoComplete search')),
        backgroundColor: const Color(0xFFf2f2f2),
        body: FutureBuilder<List<ProductModel>?>(
          future: DbService.getAllProduct(),
          builder: (context, AsyncSnapshot<List<ProductModel>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Has error'),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Autocomplete<ProductModel>(
                        optionsBuilder: (TextEditingValue textValue) {
                          return snapshot.data!
                              .where((e) => e.name!
                                  .toLowerCase()
                                  .contains(textValue.text.toLowerCase()))
                              .toList();
                        },
                        optionsMaxHeight: 100,
                        onSelected: (value) => value.name,
                        displayStringForOption: (ProductModel model) =>
                            model.name!,
                        fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) =>
                            Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.search),
                                hintText: 'Search...',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black))),
                          ),
                        ),
                        optionsViewBuilder: (context, onSelected,
                                Iterable<ProductModel> dataList) =>
                            Material(
                          elevation: 4,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: dataList.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data!.elementAt(index);
                                return ListTile(
                                  onTap: () {
                                    onSelected(data);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (_) => InfoProductScreen(
                                                  product: data,
                                                )),
                                        (route) => false);
                                  },
                                  leading:
                                      Image.file(File(data.imageUrl ?? "")),
                                  title: Text(
                                    data.name!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(data.type!),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
