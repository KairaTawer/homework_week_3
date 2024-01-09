// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:homework_week_3/features/tasks/data/repositories/local_repo.dart'
    as _i5;
import 'package:homework_week_3/features/tasks/data/repositories/remote_repo.dart'
    as _i7;
import 'package:homework_week_3/features/tasks/domain/language_use_case.dart'
    as _i3;
import 'package:homework_week_3/features/tasks/domain/tasks_use_case.dart'
    as _i4;
import 'package:homework_week_3/features/tasks/service/mock_service.dart'
    as _i6;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.GetSelectedLanguageUseCase>(
        () => _i3.GetSelectedLanguageUseCase());
    gh.factory<_i4.GetTasksListUseCase>(() => _i4.GetTasksListUseCase());
    gh.factory<_i5.LocalRepository>(() => _i5.LocalRepository());
    gh.factory<_i6.MockService>(() => _i6.MockService());
    gh.factory<_i7.RemoteRepository>(() => _i7.RemoteRepository());
    gh.factory<_i3.SetSelectedLanguageUseCase>(
        () => _i3.SetSelectedLanguageUseCase());
    return this;
  }
}
