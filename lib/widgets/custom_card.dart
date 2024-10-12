// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AlumniCard extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  AlumniCard({required this.index, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight / 48),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          transform: isSelected 
              ? Matrix4.identity().scaled(1.1) // Corrected the scale transformation
              : Matrix4.identity().scaled(0.9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected ? Colors.blue.shade600 : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: screenHeight / 75,
                offset: Offset(0, screenHeight / 75),
              ),
            ],
          ),
          child: Row(
            children: [
              // Image Section
              Container(
                width: screenWidth / 3,
                height: screenHeight / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  // image: DecorationImage(
                  //   image: AssetImage('assets/alumni_$index.png'),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              // Text Section
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth / 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alumni $index',
                        style: TextStyle(
                          fontSize: screenHeight / 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      SizedBox(height: screenHeight / 64),
                      Text(
                        'Description of alumni $index',
                        style: TextStyle(
                          fontSize: screenHeight / 48,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
