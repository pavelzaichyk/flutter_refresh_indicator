import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_state.dart';
import '../bloc/item_event.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Items List')),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () async {
              final bloc = context.read<ItemBloc>();
              final future = bloc.stream.firstWhere(
                (state) => state.status != Status.refreshing,
              );
              context.read<ItemBloc>().add(RefreshItems());
              await future;
            },
            child: ListView.builder(
              itemCount: state.items!.length,
              itemBuilder: (context, index) {
                final item = state.items![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    leading: CircleAvatar(child: Text(item.id)),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
