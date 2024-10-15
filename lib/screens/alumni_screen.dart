import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:alumni_connect/services/alumni_data.dart';
import 'package:alumni_connect/widgets/custom_card.dart'; // Import the updated AlumniCard

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

  @override
  void initState() {
    super.initState();
    fetchAlumniData();
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isFetchingMore && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  fetchAlumniData();
                  return true;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: alumniItems.length + (isFetchingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == alumniItems.length) {
                    return Center(child: CircularProgressIndicator());
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
            ),
    );
  }
}