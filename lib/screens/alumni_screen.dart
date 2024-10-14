// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:alumni_connect/widgets/custom_card.dart';

class AlumniScreen extends StatefulWidget {
  @override
  _AlumniScreenState createState() => _AlumniScreenState();
}

class _AlumniScreenState extends State<AlumniScreen> {
  int? selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 24, vertical: screenHeight / 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return AlumniCard(
                    index: index,
                    isSelected: selectedCardIndex == index,
                    onTap: () {
                      setState(() {
                        selectedCardIndex = index;
                      });
                    },
                  );
                },
                childCount: 10, // Number of cards
              ),
            ),
          ),
        ],
      ),
    );
  }
}
