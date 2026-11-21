import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cats_cubit.dart';
import '../cubit/cats_state.dart';

class CatsPage extends StatelessWidget {
  const CatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Осипов Роман — Котики'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            tooltip: 'Загрузить новые фото',
            onPressed: () => context.read<CatsCubit>().load(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<CatsCubit, CatsState>(
        builder: (context, state) {
          if (state is CatsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CatsError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Не удалось загрузить фотографии. Проверьте интернет.',
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<CatsCubit>().load(),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }
          final cats = (state as CatsLoaded).cats;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: cats.length,
            itemBuilder: (context, index) {
              final cat = cats[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      cat.url,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                          progress == null
                          ? child
                          : const SizedBox(
                              height: 250,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                      errorBuilder: (context, error, stack) => const SizedBox(
                        height: 150,
                        child: Center(child: Text('Не удалось загрузить фото')),
                      ),
                    ),
                    ListTile(
                      title: Text('Фото ${index + 1} · ID: ${cat.id}'),
                      subtitle: Text(
                        'Размер: ${cat.width} × ${cat.height} пикселей',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
