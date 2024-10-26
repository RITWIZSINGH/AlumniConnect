// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, override_on_non_overriding_member
import 'package:alumni_connect/screens/profile_screen.dart';
import 'package:alumni_connect/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final bool isLoggedIn;
  final String? userProfileImageUrl;

  CustomAppBar({this.isLoggedIn = false, this.userProfileImageUrl});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.blue.shade700,
      elevation: -10,
      pinned: false,
      floating: true,
      snap: true,
      expandedHeight: 50,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: GestureDetector(
                onTap: () {
                  if (isLoggedIn) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  backgroundImage: isLoggedIn && userProfileImageUrl != null
                      ? NetworkImage(userProfileImageUrl!)
                      : null,
                  child: !isLoggedIn
                      ? Icon(Icons.login, color: Colors.blue.shade700)
                      : null,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.black),
                  onPressed: () {
                    // Handle filter action
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
