import 'network_helper.dart';

class AlumniData {

  Future<dynamic> getAlumniData() async {
    NetworkHelper networkHelper = NetworkHelper('http://localhost:3001/ran');
    var alumniData = await networkHelper.getData();
    return alumniData;
  }
}