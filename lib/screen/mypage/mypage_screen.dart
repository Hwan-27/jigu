import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu/screen/login/login_screen.dart';
import 'package:jigu/screen/mypage/mypage_common_modify_screen.dart';
import 'package:jigu/screen/mypage/mypage_notice_screen.dart';
import 'package:jigu/screen/mypage/mypage_question_screen.dart';
import 'package:jigu/screen/mypage/mypage_seller_modify_screen.dart';
import 'package:jigu/screen/mypage/mypage_setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  var common = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      // Firestore 인스턴스 생성
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // 데이터를 가져올 컬렉션과 문서의 경로 설정
      CollectionReference usersCollection = firestore.collection('user');
      DocumentSnapshot userDocument =
          await usersCollection.doc('namchu12').get();

      // 가져온 데이터를 userData 변수에 저장
      if (userDocument.exists) {
        userData = userDocument.data() as Map<String, dynamic>;
        setState(() {}); // 화면을 다시 그리도록 알림
        print(userData);
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //알림 목록 볼 수 있는 버튼
          IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MypageNoticeScreen(),
                    ));
              },
              icon: const Icon(Icons.notifications)),
          //환경설정할 수 있는 버튼
          IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MypageSettingScreen(),
                    ));
              },
              icon: const Icon(Icons.settings))
        ],
        title: const Text(
          "마이페이지",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      //UI 보호해주는 클래스
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          //내부 여백 설정하기
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            //항목 왼쪽 정렬
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //일반계정 프로필 정보
              SizedBox(child: common ? commonProfile() : sellerProfile()),
              //나의 활동
              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 1.0),
              const SizedBox(height: 20),
              const Text("나의 활동",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              mypageRouter(context, "나의 질문", const MypageQuestionScreen()),
              const Text("나의 답변", style: TextStyle(fontSize: 20)),
              //관심목록
              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 1.0),
              const SizedBox(height: 20),
              const Text("관심목록",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              const Text("홍보글", style: TextStyle(fontSize: 20)),
              const Text("판매자", style: TextStyle(fontSize: 20)),
              //고객센터
              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 1.0),
              const SizedBox(height: 20),
              const Text("고객센터",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              const Text("문의하기", style: TextStyle(fontSize: 20)),
              const Text("공지사항", style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  onPressed: () => Get.to(() => const LoginScreen()),
                  child: const Text("Login")),
            ],
          ),
        ),
      )),
    );
  }

  //보여지는 텍스트와 넘어가는 화면 설정해주는 함수
  InkWell mypageRouter(BuildContext context, String text, dynamic pageroute) {
    return InkWell(
        //누르면 페이지 이동
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pageroute,
              ));
        },
        //보여지는 텍스트
        child: Text(text, style: const TextStyle(fontSize: 20)));
  }

  //일반프로필 설정
  Widget commonProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            //프로필 사진이 들어갈 자리
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                  child: Icon(
                Icons.camera_alt,
                color: Colors.white.withOpacity(0.8),
              )),
            ),
            const SizedBox(width: 15),
            //닉네임, 주소 자리
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData?['name'] ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                const Text("서울 신림동", style: TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                //사업자로 바뀌는 버튼
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        common = !common;
                      });
                    },
                    child: const Text("사업자전환")),
              ],
            ),
          ],
        ),
        //프로필 수정 자리
        TextButton(
          onPressed: () {
            Get.to(() => const MypageCommonModifyScreen());
          },
          child: Text(
            "프로필 수정",
            style: TextStyle(fontSize: 15, color: Colors.blue[300]),
          ),
        ),
      ],
    );
  }

  //사업자프로필 설정
  Widget sellerProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            //프로필 사진이 들어갈 자리
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                  child: Icon(
                Icons.camera_alt,
                color: Colors.white.withOpacity(0.8),
              )),
            ),
            const SizedBox(width: 15),
            //닉네임, 주소 자리
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("세븐일레븐",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                const Text("해운대구 중동", style: TextStyle(fontSize: 15)),
                //일반 계정으로 바뀌는 버튼
                const SizedBox(height: 5),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        common = !common;
                      });
                    },
                    child: const Text("일반전환")),
              ],
            ),
          ],
        ),
        //프로필 수정 자리
        TextButton(
          onPressed: () {
            Get.to(() => const MypageSellerModifyScreen());
          },
          child: Text(
            "매장 정보 수정",
            style: TextStyle(fontSize: 15, color: Colors.blue[300]),
          ),
        ),
      ],
    );
  }
}
