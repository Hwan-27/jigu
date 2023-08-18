import 'package:flutter/material.dart';

class SeekDetailListScreen extends StatefulWidget {
  const SeekDetailListScreen({super.key});

  @override
  State<SeekDetailListScreen> createState() => _SeekDetailListScreenState();
}

class _SeekDetailListScreenState extends State<SeekDetailListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이 사람의 질문 목록"),
      ),
    );
  }
}
