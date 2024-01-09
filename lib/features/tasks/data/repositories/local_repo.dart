import 'package:hive_flutter/hive_flutter.dart';
import 'package:homework_week_3/features/tasks/domain/language_model.dart';
import 'package:homework_week_3/utils/constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocalRepository {
  
  var hive = Hive.box(appBoxName);

  Language getSelectedLanguage() {
    String? selectedLanguageCode = hive.get(selectedLanguageKey);

    Language selectedLanguage = Language.values.firstWhere((element) => element.code == selectedLanguageCode, orElse: () => Language.kz);

    return selectedLanguage;
  }

  void setSelectedLanguage(Language language) {
    hive.put(selectedLanguageKey, language.code);
  }
}