import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class AlumniScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Alumni $index'),
          );
        },
      ),
    );
  }
}
