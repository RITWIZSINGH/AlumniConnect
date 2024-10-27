// ignore_for_file: unnecessary_type_check, avoid_print, unused_import
// alumni_data.dart
import 'dart:convert';
import 'network_helper.dart';

class AlumniData {
  List<int> loadedIndexes = [];

 Future<Map<String, dynamic>> getAlumniData() async {
    NetworkHelper networkHelper = NetworkHelper('http://localhost:3001/ran');

    // Convert loadedIndexes to a list of integers
    List<int> intIndexes = loadedIndexes
        .map((e) => e is int ? e : int.parse(e.toString()))
        .toList();
    print('this is the intIndexes $intIndexes');

    // Prepare the request body
    // Map<String, dynamic> requestBody = {
    //   'exclude': intIndexes,
    // };

    // Send the request with the body
    var response = await networkHelper.postData(intIndexes);

    if (response is Map<String, dynamic> && response.containsKey('indexes')) {
      // Add new indexes to loadedIndexes
      loadedIndexes.addAll(response['indexes'].cast<int>());
      print(loadedIndexes);
    }

    return response;
  }


  // New function for searching alumni data
  Future<Map<String, dynamic>> searchAlumniData(String query) async {
  final String searchUrl = 'http://localhost:3001/search?q=$query';
  NetworkHelper networkHelper = NetworkHelper(searchUrl);

  var response = await networkHelper.getData(); // Assuming getData handles GET requests

  if (response is Map<String, dynamic> && response.containsKey('items')) {
    return response;
  } else {
    print('Unexpected search format');
    return {}; // Return an empty map if the response is unexpected
  }
}

}
