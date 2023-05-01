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
  String? pcItemValue;

  List<String?> pcItem = [
    'kg',
    'liter',
    'gramm',
    'piece',
  ];
  final TextEditingController typeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (widget.product != null) {
      nameController.text = widget.product!.name!;
      costController.text = widget.product!.cost!;
      numberController.text = widget.product!.number!;
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
                  'Create a cost',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                InputTextField(
                    textEditingController: costController,
                    hinText: 'Enter the cost'),
                const SizedBox(height: 15),
                const Text(
                  'Create a number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                InputTextField(
                    textEditingController: numberController,
                    hinText: 'Enter the number'),
                const SizedBox(height: 15),
                const Text(
                  'Create type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                InputTextField(
                  hinText: 'Type here.....',
                  textEditingController: typeController,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Select an amount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                DropdownButton<String>(
                    onTap: () {},
                    hint: const Text('Select piece'),
                    value: pcItemValue,
                    items: pcItem.map((String? value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value!));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        pcItemValue = value;
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
                          final number = numberController.value.text;
                          final image = imageFile;
                          final type = typeController.text;

                          if (name.isEmpty ||
                              cost.isEmpty ||
                              image == null ||
                              type.isEmpty ||
                              number.isEmpty) {
                            return;
                          }

                          final ProductModel model = ProductModel(
                              cost: cost,
                              count: pcItemValue,
                              id: const Uuid().v1(),
                              name: name,
                              number: number,
                              imageUrl: image.path,
                              type: type);

                          if (widget.product == null) {
                            await DbService.addProduct(model);
                            print(
                                'Model qoshildiiii ------------ ${model.imageUrl}');
                          } else if (widget.product != null ||
                              widget.product!.imageUrl != null ||
                              widget.product!.count != null ||
                              widget.product!.type != null) {
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
