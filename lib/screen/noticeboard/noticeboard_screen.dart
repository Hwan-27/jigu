import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:jigu/Class/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu/Class/FirebaseService.dart';
import 'package:jigu/screen/noticeboard/noticeboard_AddNotice.dart';
import 'package:jigu/screen/noticeboard/noticeboard_kategorie_screen.dart';
import 'package:jigu/screen/noticeboard/noticeboard_place_screen.dart';
import 'package:jigu/screen/search/search_screen.dart';
import 'noticeboard_detail_screen.dart';
import 'package:firebase_database/firebase_database.dart';

class NoticeboardScreen extends StatefulWidget {
  const NoticeboardScreen({super.key});

  @override
  State<NoticeboardScreen> createState() => _NoticeboardScreenState();
}

Api_Service apiService = Api_Service();

FirebaseService firebase_ = FirebaseService();

class _NoticeboardScreenState extends State<NoticeboardScreen> {
  //선택하는 값 초기화
  var selectKategorie = "";
  var selectPlace = "";
  //카테고리, 지역설정에서 데이터 받는 함수
  selcetValue(dynamic value, String text) {
    if (value == "") {
      return text;
    }
    return value;
  }

  var notices = [];
  var colorCode = [100, 300, 400, 500, 100, 300, 400, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: SizedBox(
            width: 107,
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  selectPlace =
                      await Get.to(() => const NoticeboardPlaceScreen());
                } catch (e) {
                  selectPlace = selectPlace;
                }
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0, backgroundColor: Colors.grey[850]),
              child: Row(
                children: [
                  Text(
                    selcetValue(selectPlace, "덕천동"),
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const NoticeAddScreen());
            },
            child: Container(
              width: 70,
              height: 100,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_document,
                    color: Colors.deepOrange,
                    size: 30,
                  ), // 아이콘
                  SizedBox(width: 6.5),
                  //Text('게시글 추가', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
          ),
          //이 버튼 만드는데 3일 걸림
          //카테고리 버튼 설정
          ElevatedButton(
            //카테고리 버튼 누르면 화면 전환
            onPressed: () async {
              //선택할 경우
              try {
                selectKategorie =
                    await Get.to(() => const NoticeboardKategorieScreen());
                //선택안하고 돌아올경우
              } catch (e) {
                selectKategorie = selectKategorie;
              }
              setState(() {});
            },
            //버튼 입체감 없애기
            style: ElevatedButton.styleFrom(
                elevation: 0, backgroundColor: Colors.grey[850]),
            //텍스트 설정

            child: Row(
              children: [
                Text(
                  selcetValue(selectKategorie, ""),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Icon(
                  Icons.tune,
                  color: Colors.white,
                )
              ],
            ),
          ),

          //검색화면에 검색과 토글버튼 생성 예정
          IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(children: [
        FutureBuilder<List<Map<String, dynamic>>?>(
          future: firebase_.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              //오류
              return Center(
                child: Text('Error :${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              return const Center(child: Text('데이터가 없습니다.'));
            } else {
              // 데이터를 표시할 내용
              return GestureDetector(
                onTap: () {
                  Get.to(() => const NoticeboardDetailScreen());
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    RxBool isLiked = false.obs;
                    final notice = snapshot.data?[index];
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.1, color: Colors.grey),
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      height: 120,
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notice?['title'] ?? '1',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        notice?['content'] ?? '1',
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(() {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          isLiked.value = !isLiked.value;
                                        },
                                        icon: Icon(
                                          isLiked.value
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isLiked.value
                                              ? Colors.red[400]
                                              : Colors.white,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
