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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CustomAppBar(),
          SliverToBoxAdapter(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(), // Empty container if not loading
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == alumniItems.length) {
                  if (isFetchingMore) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return null; // Return null to stop building more items
                  }
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
              childCount: alumniItems.length + (isFetchingMore ? 1 : 0),
            ),
          ),
        ],
      ),
    );
  }
}