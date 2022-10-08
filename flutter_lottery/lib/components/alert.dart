import 'package:flutter/material.dart';

Future<String?> alertDialog(BuildContext context) async {
  return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("提示信息"),
          content: const Text("确定删除吗？"),
          actions: [
            TextButton(
              child: const Text("取消"),
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
            ),
            TextButton(
                child: const Text("确定"),
                onPressed: () {
                  Navigator.pop(context, "ok");
                })
          ],
        );
      });
}
