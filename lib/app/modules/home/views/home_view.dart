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
                  buildWalletAction(
                    context: context,
                    title: "Withdraw",
                    iconData: Icons.mobile_friendly_rounded,
                  ),
                  const SizedBox(width: 20),
                  buildWalletAction(
                    context: context,
                    title: "Deposit",
                    iconData: Icons.add_outlined,
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
                height: Get.height * 0.435,
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
