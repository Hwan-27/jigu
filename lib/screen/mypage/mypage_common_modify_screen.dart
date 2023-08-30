import 'package:flutter/material.dart';

class MypageCommonModifyScreen extends StatefulWidget {
  const MypageCommonModifyScreen({super.key});

  @override
  State<MypageCommonModifyScreen> createState() =>
      _MypageCommonModifyScreenState();
}

class _MypageCommonModifyScreenState extends State<MypageCommonModifyScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //키보드 내리기
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          //타이틀 여백 설정 - 없애버림
          titleSpacing: 0,
          title: const Text(
            "프로필 수정",
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            //완료 버튼
            ElevatedButton(
              onPressed: () {},
              //버튼 입체감 없애기
              style: ElevatedButton.styleFrom(
                  elevation: 0, backgroundColor: Colors.grey[850]),
              child: const Text(
                "완료",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                    child: Icon(
                  Icons.camera_alt,
                  color: Colors.white.withOpacity(0.8),
                )),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "닉네임",
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2))),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "나의 지역 설정",
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.8))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2))),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget myTextField(String text) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
