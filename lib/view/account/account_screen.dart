import 'package:flutter/material.dart';
import 'package:kfc/view/account/widgets/account_widgets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: AccountWidgets(
        username: "Username",
      ),
    );
  }
}
