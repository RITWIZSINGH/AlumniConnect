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