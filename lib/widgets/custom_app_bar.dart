// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, override_on_non_overriding_member, prefer_const_constructors_in_immutables
// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:alumni_connect/screens/profile_screen.dart';
import 'package:alumni_connect/screens/login_screen.dart';

class CustomAppBar extends StatelessWidget {
  final TextEditingController searchController;

  CustomAppBar({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.blue.shade700,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.login, color: Colors.blue.shade700),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.filter_list, color: Colors.black),
                onPressed: () {
                  // Handle filter action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
