import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/item_bloc.dart';
import 'bloc/item_event.dart';
import 'screens/item_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc()..add(LoadItems()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ItemListScreen(),
      ),
    );
  }
}
