import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uiwithcomponent/clonewithriverpod/model/user_model.dart';

import 'package:uiwithcomponent/riverpod/services/services.dart';
import 'package:uiwithcomponent/src/common_widgets/show_menu.dart';

class RiverPodAPiScreen extends ConsumerWidget {
  const RiverPodAPiScreen({super.key});

  @override
  Widget build(context, ref) {
    final userWatch = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('API EXAMPLE RIVERPOD')),
      body: userWatch.when(
          data: (data) {
            List<Users> userList = data.map((e) => e).toList();
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(left: 5.h, right: 5.h),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyShowDailogBox(userList[index])));
                  },
                  child: Card(
                    color: Colors.amber,
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(
                        userList[index].username,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userList[index].name),
                          Gap(2.h),
                          Text(userList[index].email),
                          Gap(2.h),
                          Text(userList[index].phone),
                          Gap(2.h),
                          Text(userList[index].website),
                          Gap(2.h),
                          Text(userList[index].id.toString()),
                          Text(userList[index].company.toString()),
                          Text(userList[index].id.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
