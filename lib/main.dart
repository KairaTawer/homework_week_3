import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => ListItemBloc(),
          child: const MyHomePage(title: 'Flutter Bloc List Example'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
  Widget build(BuildContext context) {
    final listItemBloc = BlocProvider.of<ListItemBloc>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter text here'),
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
                  child: const Text('Submit'),
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
