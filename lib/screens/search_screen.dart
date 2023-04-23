import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inware_task_app/db_helper/db_service.dart';
import 'package:inware_task_app/model/product_model.dart';
import 'package:inware_task_app/widgets/search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<ProductModel> productModel = <ProductModel>[];
  final List<ProductModel> productDisplay = <ProductModel>[];
  final ProductModel? product = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Container(
          padding: const EdgeInsets.only(left: 5),
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: TextField(
            onChanged: (value) {
              setState(() {
                productDisplay.addAll(productModel
                    .where((element) =>
                        product!.name!.toLowerCase().startsWith(value))
                    .toList());
              });
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
                hintText: 'Search...',
                border:
                    const UnderlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ),
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
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => SearchCard(
                        product: snapshot.data![index],
                      ));
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
