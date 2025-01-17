import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jigu/screen/noticeboard/noticeboard_report_screen.dart';
import 'package:jigu/screen/seller/seller_screen.dart';
import 'package:share/share.dart';

class NoticeboardDetailScreen extends StatefulWidget {
  const NoticeboardDetailScreen({super.key});

  @override
  State<NoticeboardDetailScreen> createState() =>
      _NoticeboardDetailScreenState();
}

class _NoticeboardDetailScreenState extends State<NoticeboardDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //공유버튼
          IconButton(
              onPressed: () {
                Share.share("보고있는 페이지 공유기능 구현해야 함");
              },
              icon: const Icon(Icons.share)),
          //더보기 버튼
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text("즐겨찾기")),
              PopupMenuItem(
                child: const Text("신고하기"),
                onTap: () {
                  //Get.to(() => const noticereportscreen());
                  print("신고하기 메뉴가 선택되었습니다."); // 이 부분에 print 문 추가
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const noticereportscreen(),
                      ));
                },
              )
            ],
          )
        ],
      ),
      //UI 안잘리도록 해주는 클래스
      body: SafeArea(
        //화면넘칠시 스크롤 생성
        child: CustomScrollView(
          slivers: <Widget>[
            //화면 위에 고정될 내용
            SliverToBoxAdapter(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  //본문 내용 정렬
                  alignment: Alignment.topLeft,
                  //본문 내용
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            height: 200,
                            width: 470,
                            child: const Center(
                                child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            )),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            '내용이 들어가는 부분',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            //판매자 정보
            //화면 아래에 고정됨 - 스크롤 생성될 내용에도 화면 아래에 위치
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                //화면 아래로 위치 설정
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 190,
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      const Divider(color: Colors.grey, thickness: 1.0),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          //프로필 사진
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                                child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            )),
                          ),
                          //중간 작은 공백
                          const SizedBox(width: 10),

                          //판매자 정보
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => const SellerScreen());
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "세븐일레븐 부산수영푸른빌점",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "마트/편의점",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              copyClipboardToast(
                                "부산 수영구 망미번영로16번길 74",
                              ),
                              //const SizedBox(height: 5),
                              copyClipboardToast("010-8285-3283"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //클립보드에 문자 복사와 토스트 메세지 띄움
  InkWell copyClipboardToast(String text) {
    return InkWell(
      child: Text(text,
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(1))),
      onTap: () {
        copyClipboard(text);
        copyToast();
      },
    );
  }
}

//단순히 토스트메세지 띄워주는 함수
void copyToast() {
  Fluttertoast.showToast(
    msg: "클립보드에 복사되었습니다.",
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey.withOpacity(19),
    toastLength: Toast.LENGTH_SHORT,
  );
}

//들어간 텍스트를 클립보드에 복사해주는 함수
void copyClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}
