import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SteamExample extends ConsumerStatefulWidget {
  const SteamExample({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SteamExampleState();
}

final List<String> names = [
  'John',
  'Emma',
  'Michael',
  'Olivia',
  'William',
  'Ava',
  'James',
  'Sophia',
  'Benjamin',
  'Isabella',
  'Jacob',
  'Mia',
  'Alexander',
  'Charlotte',
  'Daniel',
];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i + 1,
  ),
);

final namesProvider = StreamProvider((ref) {
  final a =
      // ignore: deprecated_member_use
      ref.watch(tickerProvider.stream).map((event) => names.getRange(0, event));
  return a;
});

class _SteamExampleState extends ConsumerState<SteamExample> {
  @override
  Widget build(BuildContext context) {
    final namesWatch = ref.watch(namesProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Stream Provider'),
        ),
        body: namesWatch.when(
          data: (data) {
            return ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(names.elementAt(index)));
              },
            );
          },
          error: (error, stackTrace) =>
              const Text('Reached the end of the list'),
          loading: () => const Center(child: CircularProgressIndicator()),
        ));
  }
}
