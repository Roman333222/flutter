import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cats_cubit.dart';
import 'requests/cats_api.dart';
import 'screens/cats_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(CatsApi())..load(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CatsPage(),
      ),
    );
  }
}
