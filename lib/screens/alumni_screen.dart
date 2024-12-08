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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  
  int? selectedCardIndex;
  List<dynamic> alumniItems = [];
  bool isLoading = true;
  int remaining = 50;
  bool isFetchingMore = false;
  AlumniData alumniData = AlumniData();
  
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

  Future<void> resetAndFetchNewAlumni() async {
    setState(() {
      alumniItems = [];
      isLoading = true;
      remaining = 50;
      isFetchingMore = false;
    });

    // Reset the AlumniData loaded indexes
    alumniData.resetLoadedIndexes();
    
    // Fetch new alumni data
    await fetchAlumniData();
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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.filter_list, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Active Filters (${alumniItems.length} results)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
                Spacer(),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      activeFields = [];
                      activeBranches = [];
                      activeBatch = [];
                    });
                    resetAndFetchNewAlumni();
                  },
                  icon: Icon(Icons.clear_all),
                  label: Text('Clear All'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade400,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                ...activeFields.map((field) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(field),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() {
                            activeFields.remove(field);
                          });
                          applyFilters(activeFields, activeBranches, activeBatch);
                        },
                        backgroundColor: Colors.teal.shade100,
                        labelStyle: TextStyle(color: Colors.teal.shade700),
                      ),
                    )),
                ...activeBranches.map((branch) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(branch),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() {
                            activeBranches.remove(branch);
                          });
                          applyFilters(activeFields, activeBranches, activeBatch);
                        },
                        backgroundColor: Colors.blue.shade100,
                        labelStyle: TextStyle(color: Colors.blue.shade700),
                      ),
                    )),
                ...activeBatch.map((year) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(year.toString()),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() {
                            activeBatch.remove(year);
                          });
                          applyFilters(activeFields, activeBranches, activeBatch);
                        },
                        backgroundColor: Colors.purple.shade100,
                        labelStyle: TextStyle(color: Colors.purple.shade700),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleCardTap(int? index) {
    setState(() {
      selectedCardIndex = selectedCardIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: FilterDrawer(
          onApplyFilter: applyFilters,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.teal.shade50,
                Colors.white,
              ],
            ),
          ),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              CustomAppBar(
                searchController: _searchController,
                onFilterTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
              SliverToBoxAdapter(
                child: _buildActiveFilters(),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index == alumniItems.length) {
                        return isFetchingMore
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : SizedBox.shrink();
                      }
                      var alumni = alumniItems[index];
                      return AlumniCard(
                        index: index,
                        isSelected: selectedCardIndex == index,
                        name: alumni['NAME'] ?? 'Unknown',
                        company: alumni['COMPANY'],
                        batch: alumni['BATCH'],
                        branch: alumni['BRANCH'],
                        profilePicUrl: alumni['PIC'],
                        profileLink: alumni['PROFILE'],
                        field: alumni['FIELD'],
                        onTap: () => _handleCardTap(index),
                      );
                    },
                    childCount: alumniItems.length + (isFetchingMore ? 1 : 0),
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