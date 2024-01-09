import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homework_week_3/features/tasks/domain/language_model.dart';
import 'package:homework_week_3/features/tasks/domain/language_use_case.dart';
import 'package:homework_week_3/injection.dart';

import '../../../../main.dart';

abstract class LanguageEvent {}

class SelectLanguageEvent extends LanguageEvent {
  final Language item;
  SelectLanguageEvent(this.item);
}

class LanguageBloc extends Bloc<LanguageEvent, Language> {
  final GetSelectedLanguageUseCase getLanguageUseCase;
  final SetSelectedLanguageUseCase setLanguageUseCase;

  LanguageBloc._(this.getLanguageUseCase, this.setLanguageUseCase, Language initialState)
      : super(initialState) {
    on<SelectLanguageEvent>((event, emit) => _onSelectLanguage(event, emit));
  }

  static Future<LanguageBloc> create() async {
    var getLanguageUseCase = getIt<GetSelectedLanguageUseCase>();
    var setLanguageUseCase = getIt<SetSelectedLanguageUseCase>();
    var initialState = getLanguageUseCase.invoke(); // Assuming this is async
    return LanguageBloc._(getLanguageUseCase, setLanguageUseCase, initialState);
  }

  void _onSelectLanguage(SelectLanguageEvent event, Emitter<Language> emit) {
    setLanguageUseCase.invoke(event.item);
    emit(event.item);
  }
}