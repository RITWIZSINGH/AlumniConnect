// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, override_on_non_overriding_member
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SliverAppBar(
      shadowColor: Colors.black54,
      backgroundColor: Colors.blue.shade100,
      elevation: screenHeight / 37.9, // Dynamic elevation
      pinned: false,
      floating: false,
      expandedHeight: screenHeight / 9.5,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.fromLTRB(8, 8, 8, screenHeight / 400),
        title: Row(
          children: [
            CircleAvatar(),
            SizedBox(width: screenWidth / 29.5),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 64,
                      vertical: screenHeight / 400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                // Handle filter action
              },
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4),
        child: Container(
          color: Colors.blue.shade200, // Separator color
          height: 4, // Height of the separation
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
