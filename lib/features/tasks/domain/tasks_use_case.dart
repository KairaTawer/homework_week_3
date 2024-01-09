import 'package:homework_week_3/features/tasks/data/dtos/task_dto.dart';
import 'package:homework_week_3/features/tasks/data/repositories/remote_repo.dart';
import 'package:homework_week_3/injection.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTasksListUseCase {
  RemoteRepository remoteRepository = getIt<RemoteRepository>();

  Future<List<TaskDto>> invoke() {
    return remoteRepository.getTasksList();
  }
}