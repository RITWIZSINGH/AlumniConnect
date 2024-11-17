// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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

  final List<String> fields = ['IT', 'Core', 'Research'];
  final List<String> branches = [
    'Computer Science and Engineering',
    'Electronics and Communication Engineering',
    'Mechanical Engineering',
    'Materials Science & Engineering',
    'Electrical Engineering',
    'Civil Engineering',
    'Chemical Engineering'
  ];
  final List<int> batchYears = List.generate(25, (index) => 2000 + index);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
              ),
              child: Text(
                'Filter Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ExpansionTile(
              title: Text('Field'),
              children: fields.map((field) {
                return CheckboxListTile(
                  title: Text(field),
                  value: selectedFields.contains(field),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedFields.add(field);
                      } else {
                        selectedFields.remove(field);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title: Text('Branch'),
              children: branches.map((branch) {
                return CheckboxListTile(
                  title: Text(branch),
                  value: selectedBranches.contains(branch),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedBranches.add(branch);
                      } else {
                        selectedBranches.remove(branch);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title: Text('Batch'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButton<int>(
                    value: selectedBatch,
                    hint: Text('Select Batch'),
                    isExpanded: true,
                    items: batchYears.map((int year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        selectedBatch = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: EdgeInsets.symmetric(vertical: 16),
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
