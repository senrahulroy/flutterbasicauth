import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Gap(15.h),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: 'add your mind',
                  border: OutlineInputBorder(),
                  label: Text('Add Task')),
            ),
            Gap(15.h),
            ElevatedButton(onPressed: () {}, child: const Text('Add Task'))
          ],
        ),
      ),
    );
  }
}
