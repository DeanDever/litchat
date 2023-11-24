import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchPageState();
}

class _MatchPageState extends ConsumerState<MatchPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('match');
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text('Match'),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
