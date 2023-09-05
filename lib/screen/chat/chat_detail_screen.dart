import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final String userId = Get.arguments ?? '사용자 이름';
    return GestureDetector(
      //키보드 내리기
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            userId,
            style: const TextStyle(fontSize: 17, color: Colors.white),
          ),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      const PopupMenuItem(value: 0, child: Text("알림끄기")),
                      const PopupMenuItem(value: 1, child: Text("차단하기")),
                      const PopupMenuItem(value: 2, child: Text("채팅방 나가기")),
                    ],
                onSelected: (choice) {
                  switch (choice) {
                    case 0:
                      break;
                    case 1:
                      break;
                    case 2:
                      exitDialog();
                  }
                })
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[850],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "메세지를 입력하세요",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //채팅방 나가기 확인 창
  void exitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("채팅방을 나가시겠습니까?"),
          content: const Text("채팅방을 나가시면 대화내용이 삭제되고 복구 할 수 없습니다."),
          actions: <Widget>[
            //나가기 버튼 설정
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("나가기"),
            ),
            //안나가는 버튼 설정
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("취소"),
            ),
          ],
        );
      },
    );
  }
}
