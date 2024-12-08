class FilterConstants {
  static const List<String> fields = ['IT', 'Core', 'Research'];
  
  static const Map<String, String> branchMapping = {
    'Computer Science and Engineering': 'CSE',
    'Electronics and Communication Engineering': 'ECE',
    'Mechanical Engineering': 'ME',
    'Materials Science & Engineering': 'MSE',
    'Electrical Engineering': 'EE',
    'Civil Engineering': 'CE',
    'Chemical Engineering': 'CHE'
  };

  static final List<int> batchYears = List.generate(25, (index) => 2000 + index);
}