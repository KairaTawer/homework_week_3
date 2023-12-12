import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ListItemEvent {}

class AddItemEvent extends ListItemEvent {
  final String item;
  AddItemEvent(this.item);
}

class UpdateItemEvent extends ListItemEvent {
  final String item;
  final int index;
  UpdateItemEvent(this.index, this.item);
}

class RemoveItemEvent extends ListItemEvent {
  final int index;
  RemoveItemEvent(this.index);
}

class ListItemState {
  final List<String> items;
  ListItemState(this.items);
}

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  ListItemBloc() : super(ListItemState([])) {
    on<AddItemEvent>((event, emit) => _onAddItemClicked(event, emit));
    on<UpdateItemEvent>((event, emit) => _onUpdateItemCLicked(event, emit));
    on<RemoveItemEvent>((event, emit) => _onRemoveItemClicked(event, emit));
  }

  void _onAddItemClicked(AddItemEvent event, Emitter<ListItemState> emit) {
    emit(ListItemState([event.item, ...state.items]));
  }

  void _onUpdateItemCLicked(
      UpdateItemEvent event, Emitter<ListItemState> emit) {
    final updatedItems = List<String>.from(state.items);
    updatedItems[event.index] = event.item;
    emit(ListItemState(updatedItems));
  }

  void _onRemoveItemClicked(
      RemoveItemEvent event, Emitter<ListItemState> emit) {
    final updatedItems = List<String>.from(state.items)..removeAt(event.index);
    emit(ListItemState(updatedItems));
  }
}
