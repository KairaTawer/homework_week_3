import 'package:homework_week_3/features/tasks/data/dtos/task_dto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'dart:convert';

@injectable
class MockService {
  Future<List<TaskDto>> fetchData() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON

      return parseMyDataList(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  List<TaskDto> parseMyDataList(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<TaskDto>((json) => TaskDto.fromJson(json)).toList();
  }
}