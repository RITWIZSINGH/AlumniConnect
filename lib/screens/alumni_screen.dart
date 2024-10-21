// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_type_check, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:alumni_connect/services/alumni_data.dart';
import 'package:alumni_connect/widgets/custom_card.dart';

class AlumniScreen extends StatefulWidget {
  @override
  _AlumniScreenState createState() => _AlumniScreenState();
}

class _AlumniScreenState extends State<AlumniScreen> {
  int? selectedCardIndex;
  List<dynamic> alumniItems = [];
  bool isLoading = true;
  bool isFetchingMore = false;
  int remaining = 50;
  AlumniData alumniData = AlumniData();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchAlumniData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchAlumniData();
    }
  }

  Future<void> fetchAlumniData() async {
    if (isFetchingMore || remaining == 0) return;

    setState(() {
      isFetchingMore = true;
    });

    var data = await alumniData.getAlumniData();

    if (data is Map<String, dynamic> && data.containsKey('items')) {
      setState(() {
        alumniItems.addAll(data['items']);
        remaining = data['remaining'];
        isLoading = false;
        isFetchingMore = false;
      });
    } else {
      print('Unexpected data format');
      setState(() {
        isLoading = false;
        isFetchingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle navigation
                Navigator.pop(context);
              },
            ),
            // Add more ListTiles for additional menu items
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: alumniItems.length + (isFetchingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == alumniItems.length) {
                  return isFetchingMore
                      ? Center(child: CircularProgressIndicator())
                      : Container();
                }
                var alumni = alumniItems[index];
                return AlumniCard(
                  index: index,
                  isSelected: selectedCardIndex == index,
                  name: alumni['NAME'],
                  company: alumni['COMPANY'],
                  batch: alumni['BATCH'],
                  profilePicUrl: alumni['PIC'],
                  profileLink: alumni['PROFILE'],
                  onTap: () {
                    setState(() {
                      selectedCardIndex = index;
                    });
                  },
                );
              },
            ),
    );
  }
}