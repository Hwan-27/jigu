import 'package:flutter/material.dart';

class noticereportscreen extends StatelessWidget {
  const noticereportscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('신고하기')),
      body: Row(
        children: [
          const Text('신고내용'),
          Container(
            decoration: BoxDecoration(border: Border.all()),
          )
        ],
      ),
    );
  }
}
