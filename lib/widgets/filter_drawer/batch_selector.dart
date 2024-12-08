// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '/constants/filter_constant.dart';

class BatchSelector extends StatelessWidget {
  final int? selectedBatch;
  final Function(int?) onBatchSelected;

  const BatchSelector({
    Key? key,
    required this.selectedBatch,
    required this.onBatchSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'BATCH',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF1976D2),
          fontSize: 16,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color:const Color(0xFFBDBDBD)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedBatch,
                hint: const Text('Select Batch'),
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                borderRadius: BorderRadius.circular(8),
                items: FilterConstants.batchYears.map((int year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(
                      year.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: onBatchSelected,
              ),
            ),
          ),
        ),
      ],
    );
  }
}