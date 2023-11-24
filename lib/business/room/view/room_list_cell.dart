import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomListCell extends ConsumerWidget {

  RoomListCell({required this.color, this.tap});

  final Color color;

  final void Function()? tap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: tap,
        child: Container(
          decoration: BoxDecoration(color: color),
        ));
  }
}
