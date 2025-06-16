import '../models/item.dart';

enum Status { initial, loading, success, refreshing }

class ItemState {
  final Status status;
  final List<Item>? items;

  ItemState({this.status = Status.initial, this.items = const []});

  ItemState copyWith({Status? status, List<Item>? items}) {
    return ItemState(status: status ?? this.status, items: items ?? this.items);
  }
}
