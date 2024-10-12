import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class StudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(), // Use the modified SliverAppBar
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('Student $index'),
                );
              },
              childCount: 30, // Number of items in the list
            ),
          ),
        ],
      ),
    );
  }
}
