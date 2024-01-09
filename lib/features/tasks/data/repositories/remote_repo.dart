
import 'package:homework_week_3/features/tasks/data/dtos/task_dto.dart';
import 'package:homework_week_3/features/tasks/service/mock_service.dart';
import 'package:homework_week_3/injection.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteRepository {
  final MockService mockService = getIt<MockService>();

  Future<List<TaskDto>> getTasksList() {
    return mockService.fetchData();
  }
}