import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:litchat/business/me/entity/setting_function_entity.dart';

class SettingCell extends ConsumerWidget {
  SettingCell({required this.item, this.onTap});

  final _valueProvider = StateProvider<String>((ref) => '');

  final void Function()? onTap;

  final SettingFunctionEntity item;

  Widget _generateArrow() {
    if (item.type == SettingFunction.version) {
      return const SizedBox(
        width: 16,
      );
    }
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.only(right: 16),
      child: Image.asset(
        'assets/common/common_arrow_gray_img.png',
        width: 24,
        height: 24,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var value = ref.watch(_valueProvider);
    item.value.then((value) {
      ref.read(_valueProvider.notifier).state = value;
    });
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 64,
          color: const Color(0xFFFFFFFF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: Text(item.title,
                    style: const TextStyle(
                        color: Color(0xFF333333), fontSize: 16)),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                          color: Color(0xFFAFB0BA), fontSize: 15),
                    ),
                    _generateArrow()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
