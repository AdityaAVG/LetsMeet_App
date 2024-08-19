import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Account'),
      bottomNavigationBar: CustomBottomNavBar(),
      body: Center(child: Text('Account Content Here')),
    );
  }
}
