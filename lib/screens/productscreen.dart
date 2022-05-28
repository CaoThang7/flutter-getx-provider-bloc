import 'package:flutter/material.dart';
import 'package:flutter_getx_provider_bloc/controllers/counterCtrl.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var countCtrl = Get.put(Counter());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),
      ),
      body: Center(
        child: Obx(() => Text('${countCtrl.count}')),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          countCtrl.add();
        },
      ),
    );
  }
}
