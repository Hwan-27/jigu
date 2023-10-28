import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu/screen/noticeboard/noticeboard_kategorie_screen.dart';
import 'package:jigu/screen/noticeboard/noticeboard_place_screen.dart';
import 'package:jigu/screen/search/search_screen.dart';
import 'noticeboard_detail_screen.dart';
import 'package:http/http.dart' as http;

class NoticeboardScreen extends StatefulWidget {
  const NoticeboardScreen({super.key});

  @override
  State<NoticeboardScreen> createState() => _NoticeboardScreenState();
}

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

  @override
  void initState() {
    super.initState();
    ApiData();
  }

  //JSONPlaceHolder 데이터 값 가져오는 함수
  Future<void> ApiData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data = jsonDecode(response.body);

      setState(() {
        notices = data
            .map((item) => {
                  'title': item['title'].toString(),
                  'body': item['body'].toString(),
                })
            .toList();
      });
    } else {
      // API 호출은 성공했지만 응답이 200이 아닌 경우에 대한 처리
      print('API 호출 실패 - 응답 코드: ${response.statusCode}');
    }
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
          // ElevatedButton(
          //   onPressed: () async {
          //     // 선택할 경우
          //     try {
          //       selectPlace =
          //           await Get.to(() => const NoticeboardPlaceScreen());
          //       // 선택안하고 돌아올경우
          //     } catch (e) {
          //       selectPlace = selectPlace;
          //     }
          //     setState(() {});
          //   },
          //   style: ElevatedButton.styleFrom(elevation: 0),
          //   child: Row(
          //     children: [
          //       const Icon(
          //         Icons.keyboard_double_arrow_down,
          //       ),
          //       const SizedBox(width: 8), // 아이콘과 텍스트 사이의 간격 조정
          //       Text(
          //         selcetValue(selectPlace, "지역 설정"),
          //         style: const TextStyle(color: Colors.white, fontSize: 17),
          //       ),
          //     ],
          //   ),
          // ),

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
      body: GestureDetector(
          //홍보글을 누르면 해당 상세내용으로 넘어감
          onTap: () {
            Get.to(() => const NoticeboardDetailScreen());
          },
          child: ListView.builder(
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final notice = notices[index];
              return Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.1, color: Colors.grey))),
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
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey.withOpacity(0.8),
                        //       spreadRadius: 1,
                        //       blurRadius: 5,
                        //       offset: const Offset(0, 3)),
                        // ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        //     child: Text(
                        //   "메인 사진",
                        //   style: TextStyle(color: Colors.white),
                        // )
                      ),
                    ),
                    //Flexible 텍스트 넘침 방지
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notice['title'],
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            notice['body'],
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9)),
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
