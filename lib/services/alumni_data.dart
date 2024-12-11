// ignore_for_file: unnecessary_type_check, avoid_print, unused_import
// alumni_data.dart
import 'dart:convert';
import 'network_helper.dart';

class AlumniData {
  List<int> loadedIndexes = [];

  void resetLoadedIndexes() {
    loadedIndexes.clear();
  }

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

    var response =
        await networkHelper.getData(); // Assuming getData handles GET requests

    if (response is Map<String, dynamic> && response.containsKey('items')) {
      return response;
    } else {
      print('Unexpected search format');
      return {}; // Return an empty map if the response is unexpected
    }
  }

  //Filtering Function for alumni's
  Future<Map<String, dynamic>> filterAlumniData({
    List<String> field = const [],
    List<String> branch = const [],
    List<int> batch = const [],
  }) async {
    NetworkHelper networkHelper = NetworkHelper("http://localhost:3001/filter");

    // Prepare the filter criteria
    Map<String, dynamic> filterBody = {
      'field': field,
      'branch': branch,
      'batch': batch,
    };

    print('Sending filter request with criteria: ${jsonEncode(filterBody)}');

    try {
      // Send POST request with filter criteria
      var response = await networkHelper.postFilterData(filterBody);

      // Check if response contains items
      if (response is Map && response.containsKey('items')) {
        print(
            'Received ${(response['items'] as List).length} filtered results');
        return response;
      } else {
        print('Unexpected response format: $response');
        return {'items': [], 'error': 'Invalid response format'};
      }
    } catch (e) {
      print('Error filtering alumni data: $e');
      return {'items': [], 'error': e.toString()};
    }
  }
}
