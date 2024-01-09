import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homework_week_3/features/tasks/domain/language_model.dart';
import 'package:homework_week_3/features/tasks/presentation/blocs/languages_bloc.dart';
import 'package:homework_week_3/utils/constants.dart';
import 'features/tasks/presentation/blocs/tasks_bloc.dart';
import 'features/tasks/presentation/screens/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'injection.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(appBoxName);
  configureDependencies();
  LanguageBloc languageBloc = await LanguageBloc.create();
  runApp(MyApp(languageBloc: languageBloc));
}

class MyApp extends StatefulWidget {

  final LanguageBloc languageBloc;

  const MyApp({super.key, required this.languageBloc});

  @override
  _MyAppState createState() => _MyAppState(languageBloc: languageBloc);
}

class _MyAppState extends State<MyApp> {
  late Locale _locale = Locale.fromSubtags(languageCode: Hive.box(appBoxName).get(selectedLanguageKey, defaultValue: Language.kz.code));

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  LanguageBloc languageBloc;
  _MyAppState({required this.languageBloc});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<LanguageBloc>.value(
      value: languageBloc,
      child: BlocBuilder<LanguageBloc, Language>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            locale: Locale.fromSubtags(languageCode: state.code),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MultiBlocProvider(
              providers: [
                BlocProvider<ListItemBloc>(
                  create: (context) => ListItemBloc(),
                ),
                BlocProvider<LanguageBloc>(
                  create: (context) => languageBloc,
                ),
              ],
              child: const MyHomePage()
            )
          );
        }
      ),
    );
  }
}