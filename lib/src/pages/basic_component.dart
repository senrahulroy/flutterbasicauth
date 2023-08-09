import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uiwithcomponent/src/pages/component/all_input_field.dart';

class BasicComponent extends ConsumerWidget {
  const BasicComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            basicBtn(
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllInputField(),
                    ));
              },
              const Text("All Input Field"),
            )
          ],
        ),
      ),
    );
  }
}

Widget basicBtn(VoidCallback onPressed, Widget child) => MaterialButton(
      color: Colors.amber,
      onPressed: onPressed,
      child: child,
    );
