import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum WalletActionType {
  deposit,
  withdraw,
}

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController amountTextEditingController = TextEditingController();
  var currentBalance = 200.00.obs;
  var selectedAmount = 0.0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    amountTextEditingController.dispose();
    super.onClose();
  }

  void submitWalletForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      //TODO: Call API
      print("Something has to be done!");
      formKey.currentState!.reset();
    }
  }

  String? validateAmount(String? value) {
    if (value!.isEmpty) {
      return "empty_amount_error".tr;
    } else if (double.parse(value) > currentBalance.value) {
      return "invalid_amount_error2".tr;
    }
    return null;
  }

  void updateSelectedAmount(String? value) {
    if (value!.isEmpty) {
      selectedAmount.value = 0.0;
    } else {
      selectedAmount.value = double.parse(value);
    }
  }
}
