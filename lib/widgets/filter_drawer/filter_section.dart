// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final List<MapEntry<String, String>> items;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;

  const FilterSection({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(title, style: AppTypography.sectionTitle),
        backgroundColor: AppColors.background,
        collapsedBackgroundColor: AppColors.background,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isSelected = selectedItems.contains(item.value);
              
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.selected : AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CheckboxListTile(
                  title: Text(item.key, style: AppTypography.listItem),
                  value: isSelected,
                  activeColor: AppColors.primary,
                  checkColor: AppColors.textLight,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onChanged: (bool? value) {
                    final updatedItems = List<String>.from(selectedItems);
                    if (value == true) {
                      updatedItems.add(item.value);
                    } else {
                      updatedItems.remove(item.value);
                    }
                    onSelectionChanged(updatedItems);
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}