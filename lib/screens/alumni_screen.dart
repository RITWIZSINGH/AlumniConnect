import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:alumni_connect/services/network_helper.dart';
import 'package:alumni_connect/services/alumni_data.dart'; // Import the AlumniData class
import 'package:alumni_connect/widgets/custom_card.dart'; // Custom card widget

class AlumniScreen extends StatefulWidget {
  @override
  _AlumniScreenState createState() => _AlumniScreenState();
}

class _AlumniScreenState extends State<AlumniScreen> {
    int? selectedCardIndex;
  List<dynamic> alumniItems = [];
  bool isLoading = true;
  bool isFetchingMore = false;
  List<dynamic> loadedIndexes = []; // Changed to List<dynamic>
  int remaining = 50;

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

    AlumniData alumniData = AlumniData();
    
    var data = await alumniData.getAlumniData(loadedIndexes);

    if (data is Map<String, dynamic> && data.containsKey('items')) {
      setState(() {
        alumniItems.addAll(data['items']);
        loadedIndexes.addAll(data['indexes']);
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isFetchingMore && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  // Fetch more data when reaching the bottom
                  fetchAlumniData();
                  return true;
                }
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  CustomAppBar(),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth / 24, vertical: screenHeight / 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var alumni = alumniItems[index];

                          if (alumni != null) {
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
                          } else {
                            return SizedBox(); // Return an empty widget if data is null
                          }
                        },
                        childCount: alumniItems.length, // Number of alumni items
                      ),
                    ),
                  ),
                  if (isFetchingMore)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()), // Loading indicator for pagination
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
