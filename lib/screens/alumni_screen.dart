// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_type_check, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/filter_drawer.dart';
import '../services/alumni_data.dart';
import '../widgets/custom_card.dart';
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
  
  // Add filter state variables
  List<String> activeFields = [];
  List<String> activeBranches = [];
  List<int> activeBatch = [];

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
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
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

  Future<void> applyFilters(List<String> fields, List<String> branches, List<int> batch) async {
    setState(() {
      isLoading = true;
      activeFields = fields;
      activeBranches = branches;
      activeBatch = batch;
    });

    var filteredData = await alumniData.filterAlumniData(
      field: fields,
      branch: branches,
      batch: batch,
    );

    setState(() {
      alumniItems = filteredData['items'] ?? [];
      isLoading = false;
    });
  }

  Widget _buildActiveFilters() {
    if (activeFields.isEmpty && activeBranches.isEmpty && activeBatch.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Active Filters (${alumniItems.length} results)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    activeFields = [];
                    activeBranches = [];
                    activeBatch = [];
                  });
                  fetchAlumniData();
                },
                child: Text('Clear All'),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            children: [
              ...activeFields.map((field) => Chip(
                    label: Text(field),
                    onDeleted: () {
                      setState(() {
                        activeFields.remove(field);
                      });
                      applyFilters(activeFields, activeBranches, activeBatch);
                    },
                  )),
              ...activeBranches.map((branch) => Chip(
                    label: Text(branch),
                    onDeleted: () {
                      setState(() {
                        activeBranches.remove(branch);
                      });
                      applyFilters(activeFields, activeBranches, activeBatch);
                    },
                  )),
              ...activeBatch.map((year) => Chip(
                    label: Text(year.toString()),
                    onDeleted: () {
                      setState(() {
                        activeBatch.remove(year);
                      });
                      applyFilters(activeFields, activeBranches, activeBatch);
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: FilterDrawer(
          onApplyFilter: applyFilters,
        ),
        body: Container(
          color: Colors.teal.shade100,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              CustomAppBar(
                searchController: _searchController,
                onFilterTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
              SliverToBoxAdapter(
                child: _buildActiveFilters(),
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
      ),
    );
  }
}