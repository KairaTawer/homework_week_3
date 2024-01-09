import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homework_week_3/features/tasks/data/dtos/task_dto.dart';
import 'package:homework_week_3/features/tasks/data/repositories/local_repo.dart';
import 'package:homework_week_3/features/tasks/domain/tasks_use_case.dart';
import 'package:homework_week_3/injection.dart';

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

class GetItemsEvent extends ListItemEvent {}

class ListItemState {
  final List<String> items;
  ListItemState(this.items);
}

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  GetTasksListUseCase useCase = getIt<GetTasksListUseCase>();

  ListItemBloc() : super(ListItemState([])) {
    on<GetItemsEvent>((event, emit) => _onGetItems(emit));
    on<AddItemEvent>((event, emit) => _onAddItemClicked(event, emit));
    on<UpdateItemEvent>((event, emit) => _onUpdateItemCLicked(event, emit));
    on<RemoveItemEvent>((event, emit) => _onRemoveItemClicked(event, emit));
  }

  void _onGetItems(Emitter<ListItemState> emit) async {
    List<TaskDto> tasks = await useCase.invoke();
    emit(ListItemState(tasks.map((task) => task.title).toList()));
  }

  void _onAddItemClicked(AddItemEvent event, Emitter<ListItemState> emit) {
    emit(ListItemState([event.item, ...state.items]));
  }

  void _onUpdateItemCLicked(UpdateItemEvent event, Emitter<ListItemState> emit) {
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
