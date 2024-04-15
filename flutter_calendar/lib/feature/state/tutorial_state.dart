import 'package:flutter/material.dart';

/// riverpod:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final helloWorldProvider = Provider<String>((ref) {
  return 'Riverpod';
});

class HelloWorld extends ConsumerWidget {
  const HelloWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(helloWorldProvider);

    return Text(message);
  }
}

// test counter riverpod:
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

class CounterContainer extends ConsumerWidget {
  const CounterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter: $counter',
              style: Theme.of(context).textTheme.headlineMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => ref.read(counterProvider.notifier).increment(),
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () => ref.read(counterProvider.notifier).decrement(),
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
