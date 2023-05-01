import 'package:flutter/material.dart';
import 'package:inware_task_app/db_helper/db_service.dart';
import 'package:inware_task_app/model/product_model.dart';
import 'package:inware_task_app/screens/create_product.dart';
import 'package:inware_task_app/widgets/product_card.dart';

class HomeProducts extends StatefulWidget {
  const HomeProducts({super.key});

  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      appBar: AppBar(
        title: const Text('Household items'),
        centerTitle: true,
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
                child: Text(' Has error'),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return SizedBox(
                  height: 690,
                  width: double.infinity,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return data.type == "Uy maxsulotlari"
                            ? ProductCard(
                                product: snapshot.data![index],
                                onPressedEdit: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateProduct(
                                                product: snapshot.data![index],
                                              )));
                                  setState(() {});
                                },
                                onpressedDelete: () async {
                                  await DbService.deleteProduct(
                                    snapshot.data![index],
                                  );
                                  setState(() {});
                                },
                              )
                            : const SizedBox.shrink();
                      }),
                );
              }
              return const Center(
                child: Text('Has not data'),
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
