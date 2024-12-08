// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'filter_section.dart';
import 'batch_selector.dart';
import '/widgets/common/custom_drawer_header.dart';
import '/constants/filter_constant.dart';

class FilterDrawer extends StatefulWidget {
  final Function(List<String>, List<String>, List<int>) onApplyFilter;

  FilterDrawer({required this.onApplyFilter});

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  final List<String> selectedFields = [];
  final List<String> selectedBranches = [];
  int? selectedBatch;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            CustomDrawerHeader(title: 'Filter Options'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: [
                  FilterSection(
                    title: 'FIELD',
                    items: FilterConstants.fields.map((field) => 
                      MapEntry(field, field)).toList(),
                    selectedItems: selectedFields,
                    onSelectionChanged: (items) {
                      setState(() => selectedFields.clear());
                      setState(() => selectedFields.addAll(items));
                    },
                  ),
                  Divider(height: 1, color: Color(0xFFE0E0E0)),
                  FilterSection(
                    title: 'BRANCH',
                    items: FilterConstants.branchMapping.entries.toList(),
                    selectedItems: selectedBranches,
                    onSelectionChanged: (items) {
                      setState(() => selectedBranches.clear());
                      setState(() => selectedBranches.addAll(items));
                    },
                  ),
                  Divider(height: 1, color: Color(0xFFE0E0E0)),
                  BatchSelector(
                    selectedBatch: selectedBatch,
                    onBatchSelected: (batch) {
                      setState(() => selectedBatch = batch);
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1976D2),
                    minimumSize: Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    widget.onApplyFilter(
                      selectedFields,
                      selectedBranches,
                      selectedBatch != null ? [selectedBatch!] : [],
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}