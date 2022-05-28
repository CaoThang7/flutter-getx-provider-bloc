import 'package:get/get.dart';

class Counter extends GetxController {
  RxInt count = 0.obs;

  void add() {
    count++;
  }
}
