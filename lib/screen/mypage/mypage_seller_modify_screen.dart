import 'package:flutter/material.dart';

class MypageSellerModifyScreen extends StatefulWidget {
  const MypageSellerModifyScreen({super.key});

  @override
  State<MypageSellerModifyScreen> createState() =>
      _MypageSellerModifyScreenState();
}

class _MypageSellerModifyScreenState extends State<MypageSellerModifyScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //키보드 내리기
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          //타이틀 여백 설정 - 없애버림
          titleSpacing: 0,
          title: const Text("매장 정보 수정"),
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
                    labelText: "매장명",
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.8))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue))),
              ),
              const SizedBox(height: 15),
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
