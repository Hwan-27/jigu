import 'package:flutter/material.dart';
import 'package:jigu/Class/StylyCss.dart';
import 'package:jigu/model/kategorie_model.dart';

class NoticeAddScreen extends StatelessWidget {
  NoticeAddScreen({super.key});

  final Kate = Kategorie().kategorie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '게시글 등록',
          style: Style.AppbarTitleStyle,
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                '임시저장',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                    Text(
                      '0/3',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '제목',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 600,
              child: TextField(
                decoration: InputDecoration(
                    hintText: '제목을 입력해주세요',
                    hintStyle: const TextStyle(color: Colors.grey),
                    // 선택 되었을 때
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1))),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '내용',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 600,
                  height: 150,
                  child: TextField(
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                        hintText: '내용을 입력해주세요',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.grey))),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          DropdownButton(
              padding: const EdgeInsets.only(left: 20),
              iconEnabledColor: Colors.white,
              items: Kate.keys.map((String kategorie) {
                return DropdownMenuItem<String>(
                  value: kategorie,
                  child: Text(
                    kategorie,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                print("카테고리 : $newValue");
              }),
          const SizedBox(
            height: 60,
          ),
          TextButton(
              onPressed: () {},
              child: Center(
                  child: Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      padding: const EdgeInsets.only(left: 20),
                      child: const Center(
                        child: Text(
                          '작성완료',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ))))
        ],
      ),
    );
  }
}
