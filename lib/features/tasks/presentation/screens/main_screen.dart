import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homework_week_3/features/tasks/domain/language_model.dart';
import 'package:homework_week_3/features/tasks/presentation/blocs/languages_bloc.dart';
import '../blocs/tasks_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  int? _editingItemIndex;

  void _onEnterClicked(ListItemBloc listItemBloc) {
    if (_textController.text.isEmpty) return;

    if (_editingItemIndex != null) {
      listItemBloc
          .add(UpdateItemEvent(_editingItemIndex!, _textController.text));
      _editingItemIndex = null;
    } else {
      listItemBloc.add(AddItemEvent(_textController.text));
    }

    _textController.clear();
  }

  void _editItem(ListItemBloc listItemBloc, int index) {
    setState(() {
      _textController.text = listItemBloc.state.items[index];
      _editingItemIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ListItemBloc>(context).add(GetItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final listItemBloc = BlocProvider.of<ListItemBloc>(context);
    final languageBloc = BlocProvider.of<LanguageBloc>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppLocalizations.of(context)!.title),
          actions: [
            BlocBuilder<LanguageBloc, Language>(
                builder: (context, state) {
                  return PopupMenuButton<Language>(
                    onSelected: (value) {
                      // Dispatch event to the Bloc
                      languageBloc.add(SelectLanguageEvent(value));
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<Language>>[
                        CheckedPopupMenuItem<Language>(
                          value: Language.kz,
                          checked: state == Language.kz,
                          child: const Text('KZ'),
                        ),
                        CheckedPopupMenuItem<Language>(
                          value: Language.en,
                          checked: state == Language.en,
                          child: const Text('EN'),
                        ),
                        CheckedPopupMenuItem<Language>(
                          value: Language.ru,
                          checked: state == Language.ru,
                          child: const Text('RU'),
                        )
                      ];
                    },
                  );
                },
              ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(), labelText: AppLocalizations.of(context)!.inputPlaceholder),
                controller: _textController,
                onSubmitted: (text) {
                  _onEnterClicked(listItemBloc);
                },
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _onEnterClicked(listItemBloc);
                  },
                  child: Text(AppLocalizations.of(context)!.submit),
                ),
              ),
              Expanded(child: BlocBuilder<ListItemBloc, ListItemState>(
                  builder: (context, state) {
                return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.items[index]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editItem(listItemBloc, index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  listItemBloc.add(RemoveItemEvent(index)),
                            ),
                          ],
                        ),
                      );
                    });
              })),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
