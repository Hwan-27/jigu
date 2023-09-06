import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool bookMarkCheck = false;

  @override
  Widget build(BuildContext context) {
    final String userId = Get.arguments ?? '사용자';
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
                      PopupMenuItem(
                          value: 0,
                          child: Text(bookMarkCheck ? "알림 켜기" : "알림끄기")),
                      const PopupMenuItem(value: 1, child: Text("차단하기")),
                      const PopupMenuItem(value: 2, child: Text("채팅방 나가기")),
                    ],
                onSelected: (choice) {
                  switch (choice) {
                    case 0:
                      toggleBookMarkCheck();
                      break;
                    case 1:
                      userBlock(userId);
                      break;
                    case 2:
                      exitDialog();
                      break;
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
                      style: const TextStyle(color: Colors.white),
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

  // 알림 켜기 / 끄기 체크함수
  void toggleBookMarkCheck() {
    setState(() {
      bookMarkCheck = !bookMarkCheck;
    });
    final message = bookMarkCheck ? '알림을 껐습니다.' : '알림을 켰습니다.';
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16,
        backgroundColor: Colors.grey[850]!,
        textColor: Colors.white);
  }

  //채팅방 나가기 확인 창
  void exitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "채팅방을 나가시겠습니까?",
            style: TextStyle(color: Colors.black),
          ),
          content: const Text("대화내용이 삭제됩니다."),
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

  void userBlock(String userId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              "$userId 님을 차단하면 서로의 게시글을 볼 수 없고, 서로 채팅도 보낼 수 없습니다. 차단하시겠습니까 ?",
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text("차단하기"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("취소"),
              ),
            ],
          );
        });
  }
}
