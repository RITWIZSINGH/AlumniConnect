// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, unnecessary_type_check, library_private_types_in_public_api, sort_child_properties_last, unused_import, prefer_const_constructors_in_immutables
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
      elevation: 20,
      shadowColor: Colors.black,
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
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blue.shade700),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.filter_list, color: Colors.blue.shade700),
                onPressed: () {
                  // Handle filter action
                },
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
