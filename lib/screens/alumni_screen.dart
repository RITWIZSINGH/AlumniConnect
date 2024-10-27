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
  int remaining = 50;
  bool isFetchingMore = false;
  AlumniData alumniData = AlumniData();
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAlumniData();
    _scrollController.addListener(_scrollListener);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchAlumniData();
    }
  }

  Future<void> fetchAlumniData({String query = ''}) async {
    if (isFetchingMore || remaining == 0) return;

    setState(() {
      isFetchingMore = true;
    });

    var data = await alumniData.getAlumniData();

    if (data.containsKey('items')) {
      setState(() {
        alumniItems.addAll(data['items']);
        remaining = data['remaining'];
        isLoading = false;
        isFetchingMore = false;
      });
    } else {
      setState(() {
        isLoading = false;
        isFetchingMore = false;
      });
    }
  }

  void _onSearchChanged() {
  alumniData.searchAlumniData(_searchController.text).then((data) {
    setState(() {
      alumniItems = data['items'] ?? [];
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            CustomAppBar(
              searchController: _searchController,
            ),
            SliverToBoxAdapter(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox.shrink(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == alumniItems.length) {
                    return isFetchingMore
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox.shrink();
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
      ),
    );
  }
}
