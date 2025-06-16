import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/item.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemState()) {
    on<LoadItems>(_onLoadItems);
    on<RefreshItems>(_onRefreshItems);
  }

  Future<void> _onLoadItems(LoadItems event, Emitter<ItemState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final items = await _fetchItems();

    emit(state.copyWith(status: Status.success, items: items));
  }

  Future<void> _onRefreshItems(
    RefreshItems event,
    Emitter<ItemState> emit,
  ) async {
    emit(state.copyWith(status: Status.refreshing));

    final items = await _fetchItems();

    emit(state.copyWith(status: Status.success, items: items));
  }

  Future<List<Item>> _fetchItems() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(50, (index) {
      final id = (index + 1).toString();
      return Item(
        id: id,
        title: 'Item $id',
        description:
            'This is a detailed description for item $id. It contains more information about the item and its features.',
      );
    });
  }
}
