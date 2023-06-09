import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inware_task_app/db_helper/db_service.dart';
import 'package:inware_task_app/model/product_model.dart';
import 'package:inware_task_app/screens/categoty_widgets/don_maxsulotlari.dart';
import 'package:inware_task_app/screens/categoty_widgets/ovqat_maxsulotlari.dart';
import 'package:inware_task_app/screens/categoty_widgets/ichimliklar.dart';
import 'package:inware_task_app/screens/categoty_widgets/texnika_maxsulotlari.dart';
import 'package:inware_task_app/screens/categoty_widgets/uy_maxsulotlari.dart';
import 'package:inware_task_app/screens/create_product.dart';
import 'package:inware_task_app/screens/search_screen.dart';
import 'package:inware_task_app/widgets/category_card.dart';
import 'package:inware_task_app/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      appBar: AppBar(
        toolbarHeight: 65,
        title: const Text(
          'Products',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
              splashRadius: 25,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              icon: const Icon(
                CupertinoIcons.search,
                size: 30,
              )),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateProduct()));
          },
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryCard(
                    text: 'Ovqat maxsulotlari',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const FoodProducts()));
                    },
                  ),
                  CategoryCard(
                    text: 'Ichimliklar',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const WatersProducts()));
                    },
                  ),
                  CategoryCard(
                    text: 'Texnikalar',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const TechnicalProducts()));
                    },
                  ),
                  CategoryCard(
                    text: 'Uy maxsulotlari',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const HomeProducts()));
                    },
                  ),
                  CategoryCard(
                    text: 'Don maxsulotlari',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const CerealProducts()));
                    },
                  )
                ],
              ),
            ),
            FutureBuilder<List<ProductModel>?>(
                future: DbService.getAllProduct(),
                builder:
                    (context, AsyncSnapshot<List<ProductModel>?> snapshot) {
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
                        height: 638,
                        width: double.infinity,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 20),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => ProductCard(
                                  product: snapshot.data![index],
                                  onPressedEdit: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreateProduct(
                                                  product:
                                                      snapshot.data![index],
                                                )));
                                    setState(() {});
                                  },
                                  onpressedDelete: () async {
                                    await DbService.deleteProduct(
                                      snapshot.data![index],
                                    );
                                    setState(() {});
                                  },
                                )),
                      );
                    }
                    return const Center(
                      child: Text('Has not data'),
                    );
                  }
                  return const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }
}
