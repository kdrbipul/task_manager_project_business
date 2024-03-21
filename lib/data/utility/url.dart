class Urls {
  // this is a base url
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static String completeTaskList = '$_baseUrl/listTaskByStatus/Complete';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTaskStatus(String id, String status) => '$_baseUrl/deleteTask/$id/$status';
  static String updateProfile = '$_baseUrl/profileUpdate';
}