import 'package:flutter/material.dart';
import 'package:kfc/controller/provider/profile_provider.dart';
import 'package:kfc/view/account/widgets/account_widgets.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: AccountWidgets(
        username: "Username",
      ),
    );
  }
}
