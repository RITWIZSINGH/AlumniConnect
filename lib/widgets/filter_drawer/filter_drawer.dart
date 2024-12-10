// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'filter_section.dart';
import 'batch_selector.dart';
import '../common/custom_drawer_header.dart';
import '../../constants/filter_constant.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class FilterDrawer extends StatefulWidget {
  final Function(List<String>, List<String>, List<int>) onApplyFilter;

  const FilterDrawer({
    Key? key,
    required this.onApplyFilter,
  }) : super(key: key);

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
      elevation: 0,
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            const CustomDrawerHeader(title: 'Filter Options'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  FilterSection(
                    title: 'FIELD',
                    items: FilterConstants.fields
                        .map((field) => MapEntry(field, field))
                        .toList(),
                    selectedItems: selectedFields,
                    onSelectionChanged: (items) {
                      setState(() {
                        selectedFields.clear();
                        selectedFields.addAll(items);
                      });
                    },
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  FilterSection(
                    title: 'BRANCH',
                    items: FilterConstants.branchMapping.entries.toList(),
                    selectedItems: selectedBranches,
                    onSelectionChanged: (items) {
                      setState(() {
                        selectedBranches.clear();
                        selectedBranches.addAll(items);
                      });
                    },
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  BatchSelector(
                    selectedBatch: selectedBatch,
                    onBatchSelected: (batch) {
                      setState(() => selectedBatch = batch);
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textLight,
                    minimumSize: const Size(double.infinity, 56),
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
                  child: const Text('Apply Filters', style: AppTypography.buttonText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
