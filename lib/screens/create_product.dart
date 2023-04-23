import 'package:flutter/material.dart';
import 'package:inware_task_app/db_helper/db_service.dart';
import 'package:inware_task_app/model/product_model.dart';
import 'package:inware_task_app/widgets/input_textfield.dart';

class CreateProduct extends StatelessWidget {
  final ProductModel? product;
  const CreateProduct({this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    final TextEditingController costController = TextEditingController();
    final TextEditingController countController = TextEditingController();
    if (product != null) {
      nameController.text = product!.name!;
      typeController.text = product!.type!;
      costController.text = product!.cost!;
      countController.text = product!.count!;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product == null ? 'Create product' : 'Edit product'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Create name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              InputTextField(
                hinText: 'Enter the name...',
                textEditingController: nameController,
              ),
              const SizedBox(height: 15),
              const Text(
                'Create type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              InputTextField(
                hinText: 'Enter the type...',
                textEditingController: typeController,
              ),
              const SizedBox(height: 15),
              const Text(
                'Create a number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              InputTextField(
                  textEditingController: countController,
                  hinText: 'Enter the number'),
              const SizedBox(height: 15),
              const Text(
                'Create a cost',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              InputTextField(
                  textEditingController: costController,
                  hinText: 'Enter the cost'),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        final name = nameController.value.text;
                        final type = typeController.value.text;
                        final cost = costController.value.text;
                        final count = countController.value.text;

                        if (name.isEmpty ||
                            type.isEmpty ||
                            cost.isEmpty ||
                            count.isEmpty) {
                          return;
                        }
                          
                        final ProductModel model = ProductModel(
                            cost: cost,
                            count: count,
                            id: product?.id,
                            name: name,
                            type: type);

                        if (product == null) {
                          await DbService.addProduct(model);
                          print('Model qoshildiiii ------------ $model');
                        } else {
                          await DbService.updateProduct(model);
                        }
                         // ignore: use_build_context_synchronously
                         Navigator.pop(context);
                      },
                      child: Text(
                          product == null ? 'Create product' : 'Edit Product')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
