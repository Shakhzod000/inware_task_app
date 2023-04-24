// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inware_task_app/db_helper/db_service.dart';
import 'package:inware_task_app/model/product_model.dart';
import 'package:inware_task_app/screens/home_screen.dart';
import 'package:inware_task_app/service/image_service.dart';
import 'package:inware_task_app/widgets/input_textfield.dart';
import 'package:uuid/uuid.dart';

class CreateProduct extends StatefulWidget {
  final ProductModel? product;
  const CreateProduct({this.product, super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  File? imageFile;
  final PickImage pickImage = PickImage();
  String? dropDownValue;
  List<String?> items = [
    'Food products',
    'Water products',
    'Techniques',
    'Cereal products',
    'Household items',
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (widget.product != null) {
      nameController.text = widget.product!.name!;
      costController.text = widget.product!.cost!;
      countController.text = widget.product!.count!;
    }
    super.didChangeDependencies();
  }

  void showPostCreationType(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CupertinoAlertDialog(
              title: const Text('Create post'),
              content: const Text('Choose your create type'),
              actions: [
                CupertinoDialogAction(
                    child: const Text('Camera'),
                    onPressed: () async {
                      imageFile = await pickImage
                          .pickImageFromStorage(ImageSource.camera)
                          .then((value) {
                        log(value.toString());
                        Navigator.of(context).pop();
                        return value;
                      });
                      log(imageFile.toString());
                      setState(() {});
                    }),
                CupertinoDialogAction(
                  child: const Text('Gallery'),
                  onPressed: () async {
                    imageFile = await pickImage
                        .pickImageFromStorage(ImageSource.gallery)
                        .then((value) {
                      log(value.toString());
                      Navigator.of(context).pop();
                      return value;
                    });
                    setState(() {});
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.product == null ? 'Create product' : 'Edit product'),
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Add your product image!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                        iconSize: 35,
                        onPressed: () {
                          setState(() {
                            showPostCreationType(context);
                          });
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                        )),
                  ],
                ),
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: imageFile == null
                      ? const SizedBox.shrink()
                      : Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
                const Text(
                  'Create type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                DropdownButton<String>(
                    onTap: () {},
                    hint: const Text('Select type'),
                    value: dropDownValue,
                    items: items.map((String? value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value!));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value;
                      });
                    }),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          final name = nameController.value.text;
                          final cost = costController.value.text;
                          final count = countController.value.text;
                          final image = imageFile;

                          if (name.isEmpty ||
                              cost.isEmpty ||
                              count.isEmpty ||
                              image == null) {
                            return;
                          }

                          final ProductModel model = ProductModel(
                              cost: cost,
                              count: count,
                              id: const Uuid().v1(),
                              name: name,
                              imageUrl: image.path,
                              type: dropDownValue);

                          if (widget.product == null) {
                            await DbService.addProduct(model);
                            print(
                                'Model qoshildiiii ------------ ${model.imageUrl}');
                          } else {
                            await DbService.updateProduct(model);
                          }

                          await Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen()),
                              (route) => false);
                        },
                        child: Text(widget.product == null
                            ? 'Create product'
                            : 'Edit Product')),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
