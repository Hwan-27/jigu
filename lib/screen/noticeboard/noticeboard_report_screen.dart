import 'package:flutter/material.dart';
import 'package:get/get.dart';

class noticereportscreen extends StatelessWidget {
  const noticereportscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        '게시글 신고',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '신고내용',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.5))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue)),
                  hintText: '제목을 입력해주세요.',
                  hintStyle: const TextStyle(color: Colors.white)),
              cursorWidth: 2,
              cursorHeight: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.5))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue)),
                    hintText: '내용을 입력해주세요.',
                    hintStyle: const TextStyle(color: Colors.white)),
                maxLines: 5,
                minLines: 1,
                cursorWidth: 2,
                cursorHeight: 20,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              '기타문의',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('기타문의는 help@naver.com으로'),
                Text('보내주시길 바랍니다. (문의시간 10:00 ~ 18:00)')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                '신고하기',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
