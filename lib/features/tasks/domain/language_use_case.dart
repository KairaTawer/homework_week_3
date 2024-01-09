
import 'package:homework_week_3/features/tasks/data/repositories/local_repo.dart';
import 'package:homework_week_3/injection.dart';
import 'package:injectable/injectable.dart';

import 'language_model.dart';

@injectable
class GetSelectedLanguageUseCase {
  LocalRepository localRepository = getIt<LocalRepository>();

  Language invoke() {
      return localRepository.getSelectedLanguage();
  }
}

@injectable
class SetSelectedLanguageUseCase {
  LocalRepository localRepository = getIt<LocalRepository>();

  void invoke(Language language) {
      localRepository.setSelectedLanguage(language);
  }
}