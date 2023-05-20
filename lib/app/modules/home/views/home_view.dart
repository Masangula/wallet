import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              elevation: 3,
              // color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: Get.size.height * 0.2,
                decoration: BoxDecoration(
                  // color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.5,
                  ),
                  // gradient: const LinearGradient(
                  //   colors: [Color(0xFF096C35), Color(0xFF8CD5CA)],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Text(
                        "Balance",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "TZS",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 16),
                          children: [
                            TextSpan(
                              text: "90000.00",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _buildWalletBottomSheetAction(
                        context: context,
                        walletActionType: WalletActionType.withdraw,
                      );
                    },
                    child: buildWalletAction(
                      context: context,
                      title: "Withdraw",
                      iconData: Icons.mobile_friendly_rounded,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      _buildWalletBottomSheetAction(
                        context: context,
                        walletActionType: WalletActionType.deposit,
                      );
                    },
                    child: buildWalletAction(
                      context: context,
                      title: "Deposit",
                      iconData: Icons.add_outlined,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Transanctions",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            DefaultTabController(
              length: 4,
              child: SizedBox(
                height: Get.height * 0.46,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: "All"),
                        Tab(text: "Deposits"),
                        Tab(text: "Withdraws"),
                        Tab(text: "Purchases"),
                      ],
                      dividerColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          buildTransactionTypeTabview(
                            context: context,
                            transanctionType: "All",
                            iconData: Icons.credit_score_outlined,
                          ),
                          buildTransactionTypeTabview(
                            context: context,
                            transanctionType: "Deposit",
                            iconData: Icons.credit_score_outlined,
                          ),
                          buildTransactionTypeTabview(
                            context: context,
                            transanctionType: "Withdraw",
                            iconData: Icons.mobile_friendly_rounded,
                          ),
                          buildTransactionTypeTabview(
                            context: context,
                            transanctionType: "Purchases",
                            iconData: Icons.shopping_cart,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buildWalletBottomSheetAction({
    required BuildContext context,
    required WalletActionType walletActionType,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      builder: (BuildContext context) {
        return Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        walletActionType.name.capitalizeFirst!,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 24,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.amountTextEditingController.text = "";
                          controller.selectedAmount.value = 0.0;
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 34,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                    height: 0.3,
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.amountTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      hintText:
                          "Enter amount you want to ${walletActionType.name}",
                      label: const Text("Amount"),
                    ),
                    validator: controller.validateAmount,
                    onChanged: controller.updateSelectedAmount,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildEasyMoneySelector(context: context, amount: 5000),
                      buildEasyMoneySelector(context: context, amount: 10000),
                      buildEasyMoneySelector(context: context, amount: 15000),
                      buildEasyMoneySelector(context: context, amount: 20000),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: controller.submitWalletForm,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Withdraw",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Obx buildEasyMoneySelector(
      {required BuildContext context, required double amount}) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.amountTextEditingController.text = amount.toString();
          controller.selectedAmount.value = amount;
        },
        child: Container(
          height: 60,
          width: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: amount == controller.selectedAmount.value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "$amount",
            style: TextStyle(
                color: amount == controller.selectedAmount.value
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildTransactionTypeTabview({
    required BuildContext context,
    required IconData iconData,
    required transanctionType,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTransanctionHistoryItem(
            context: context,
            transanctionType: transanctionType,
            amount: "10000.00",
            occuranceTime: DateTime.now(),
            iconData: iconData,
          ),
          buildTransanctionHistoryItem(
            context: context,
            transanctionType: transanctionType,
            amount: "10000.00",
            occuranceTime: DateTime.now(),
            iconData: iconData,
          ),
          buildTransanctionHistoryItem(
            context: context,
            transanctionType: transanctionType,
            amount: "10000.00",
            occuranceTime: DateTime.now(),
            iconData: iconData,
          ),
          buildTransanctionHistoryItem(
            context: context,
            transanctionType: transanctionType,
            amount: "10000.00",
            occuranceTime: DateTime.now(),
            iconData: iconData,
          ),
          buildTransanctionHistoryItem(
            context: context,
            transanctionType: transanctionType,
            amount: "10000.00",
            occuranceTime: DateTime.now(),
            iconData: iconData,
          ),
          buildTransanctionHistoryItem(
            context: context,
            transanctionType: transanctionType,
            amount: "10000.00",
            occuranceTime: DateTime.now(),
            iconData: iconData,
          ),
          buildTransanctionHistoryItem(
            context: context,
            transanctionType: transanctionType,
            amount: "10000.00",
            occuranceTime: DateTime.now(),
            iconData: iconData,
          ),
          buildTransanctionHistoryItem(
            context: context,
            transanctionType: transanctionType,
            amount: "10000.00",
            occuranceTime: DateTime.now(),
            iconData: iconData,
          ),
        ],
      ),
    );
  }

  Material buildWalletAction({
    required BuildContext context,
    required String title,
    required IconData iconData,
  }) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              color: Theme.of(context).colorScheme.onSurface,
              size: 30,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
            )
          ],
        ),
      ),
    );
  }

  Padding buildTransanctionHistoryItem({
    required BuildContext context,
    required String transanctionType,
    required String amount,
    required DateTime occuranceTime,
    required IconData iconData,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        // contentPadding: const EdgeInsets.all(0),
        visualDensity: const VisualDensity(vertical: -4),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 1.0,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            size: 25,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        title: Text(
          transanctionType,
        ),
        subtitle:
            Text(DateFormat.yMMMMd('en_US').add_Hm().format(occuranceTime)),
        trailing: Text(
          'TZS.$amount/=',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
