import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:uiwithcomponent/clonewithriverpod/model/user_model.dart';

class MyShowDailogBox extends ConsumerWidget {
  final Users e;
  const MyShowDailogBox(this.e, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card(
          child: ListTile(
            title: Text(e.username),
          ),
        ),
      ),
    );
  }
}
