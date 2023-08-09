import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyScaffold extends ConsumerStatefulWidget {
  final AppBar? appBar;
  final Widget body;
  const MyScaffold(this.appBar, this.body, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends ConsumerState<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
    );
  }
}
