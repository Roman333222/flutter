import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/history_cubit.dart';
import '../cubit/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История расчётов'),
        backgroundColor: Colors.blue,
        actions: [
          BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) => IconButton(
              tooltip: 'Очистить историю',
              icon: const Icon(Icons.delete_outline),
              onPressed: state.loading || state.items.isEmpty
                  ? null
                  : () async {
                      final cubit = context.read<HistoryCubit>();
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Очистить историю?'),
                          content: const Text(
                            'Все сохранённые расчёты будут удалены.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Очистить'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true && !cubit.isClosed) {
                        await cubit.clear();
                      }
                    },
            ),
          ),
        ],
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) return Center(child: Text(state.error!));
          if (state.items.isEmpty) {
            return const Center(child: Text('История пока пуста'));
          }
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return ListTile(
                title: Text(
                  '(${item['a']} + ${item['b']})² = ${item['result']}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
