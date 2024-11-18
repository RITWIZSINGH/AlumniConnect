// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

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
  final Map<String, String> branchMapping = {
    'Computer Science and Engineering': 'CSE',
    'Electronics and Communication Engineering': 'ECE',
    'Mechanical Engineering': 'ME',
    'Materials Science & Engineering': 'MSE',
    'Electrical Engineering': 'EE',
    'Civil Engineering': 'CE',
    'Chemical Engineering': 'CHE'
  };
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
              title: Text('FIELD',style: TextStyle(fontWeight: FontWeight.bold),),
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
              title: Text('BRANCH',style: TextStyle(fontWeight: FontWeight.bold),),
              children: branchMapping.keys.map((branch) {
                return CheckboxListTile(
                  title: Text(branch),
                  value: selectedBranches.contains(branchMapping[branch]),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedBranches.add(branchMapping[branch]!);
                      } else {
                        selectedBranches.remove(branchMapping[branch]!);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title: Text(
                'BATCH',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
