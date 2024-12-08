// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

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
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color:  Color(0xFF1976D2),
          fontSize: 16,
        ),
      ),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CheckboxListTile(
              title: Text(
                item.key,
                style: const TextStyle(fontSize: 14),
              ),
              value: selectedItems.contains(item.value),
              activeColor: const Color(0xFF1976D2),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              dense: true,
              onChanged: (bool? value) {
                final updatedItems = List<String>.from(selectedItems);
                if (value == true) {
                  updatedItems.add(item.value);
                } else {
                  updatedItems.remove(item.value);
                }
                onSelectionChanged(updatedItems);
              },
            );
          },
        ),
      ],
    );
  }
}