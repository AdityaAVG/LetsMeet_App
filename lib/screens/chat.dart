import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chat'),
      bottomNavigationBar: CustomBottomNavBar(),
      body: Center(child: Text('Chat Content Here')),
    );
  }
}
