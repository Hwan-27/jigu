import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu/screen/search/search_screen.dart';
import 'package:jigu/screen/seek/seek_detail_screen.dart';
import 'package:jigu/screen/seek/seek_write_screen.dart';

class SeekScreen extends StatefulWidget {
  const SeekScreen({super.key});

  @override
  State<SeekScreen> createState() => _SeekScreenState();
}

class _SeekScreenState extends State<SeekScreen> {
  var seeks = [
    "찾는글 제목이 들어갑니다.",
    "콘치즈 있는 횟집 찾습니다.",
    "파란장미 파는 꽃집 찾습니다.",
    "포토카드 뽑을 수 있는 곳을 찾습니다.",
    "많은양의 문서파기 할 수 있는 곳을 찾습니다.",
    "사진과 같은 부품을 찾습니다.",
    "짱구 지비츠 파는곳을 알려주세요.",
    "앵무새 진료가능한 동물병원 찾아요.",
  ];
  var colorCode = [100, 300, 400, 500, 100, 300, 400, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("찾아요",
            style: TextStyle(color: Colors.white, fontSize: 17)),
        actions: [
          //검색버튼
          IconButton(
              color: Colors.white,
              //누르면 화면 이동
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ));
              },
              icon: const Icon(Icons.search)),
          PopupMenuButton(
            color: Colors.white,
            //PopupMenuItem onTap 사용안하고 작동 방법
            //https://github.com/flutter/flutter/issues/81682
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 0,
                  child: Text(
                    "작성한글",
                    style: TextStyle(color: Colors.black),
                  )),
              const PopupMenuItem(
                  value: 1,
                  child: Text("작성하기", style: TextStyle(color: Colors.black))),
            ],
            onSelected: (choice) {
              switch (choice) {
                //작성한글
                case 0:
                  break;
                //작성하기
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SeekWriteScreen()),
                  );
              }
            },
          )
        ],
      ),
      body: GestureDetector(
          //찾는글을 누르면 해당 상세내용으로 넘어감
          onTap: () {
            Get.to(() => const SeekDetailScreen());
          },
          child: ListView.builder(
            itemCount: seeks.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    width: 0.1,
                    color: Colors.grey,
                  )),
                ),
                padding: const EdgeInsets.all(15),
                height: 120,
                //color: Colors.indigo[colorCode[index]],
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Icon(Icons.camera_alt,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                    //Flexible 텍스트 넘침 방지
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //찾는글 제목
                          Text(
                            seeks[index],
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "안녕하세요 이곳에는 찾는글 내용이 들어갑니다. 보이는 내용은 최대 2줄이고 넘을 경우 나머지는 잘리게 됩니다.",
                            maxLines: 2,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
