// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    print(screenWidth);
    return SliverAppBar(
      pinned: false, // Keeps the app bar pinned at the top when fully collapsed
      floating:
          false, // If true, the app bar will float over the content when scrolling up
      snap: false, // If true, the app bar will "snap" into view when scrolling
      expandedHeight: screenHeight / 8.5, // Height of the app bar when expanded
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(8.0),
        title: Row(
          children: [
            CircleAvatar(),
            SizedBox(width: screenWidth / 29.5),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth / 32),
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
    );
  }
}
