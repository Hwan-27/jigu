import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu/Class/StylyCss.dart';
import 'package:jigu/model/kategorie_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NoticeAddScreen extends StatefulWidget {
  const NoticeAddScreen({Key? key});

  @override
  State<NoticeAddScreen> createState() => _NoticeAddScreenState();
}

class _NoticeAddScreenState extends State<NoticeAddScreen> {
  List<XFile?> imageList = List.generate(3, (index) => null);

  int ListCnt = 0;

  final Kate = Kategorie().kategorie;

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        print(image.path);
        if (ListCnt < 3) {
          imageList[ListCnt] = XFile(image.path);
          ListCnt = ListCnt + 1;
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.grey[850],
                content: Text('이미지는 최대 3개까지 추가 할 수 있습니다.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '확인',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  List<Widget> ImageContainer() {
    List<Widget> ImageContainer = [];

    for (int i = 0; i < ListCnt; i++) {
      ImageContainer.add(Container(
        margin: EdgeInsets.only(left: 20),
        width: 75,
        height: 75,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: kIsWeb
            ? Image.network(
                imageList[i]!.path,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(imageList[i]!.path),
                fit: BoxFit.cover,
              ),
      ));
    }

    return ImageContainer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '게시글 등록',
          style: Style.AppbarTitleStyle,
        ),
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
              InkWell(
                onTap: () {
                  _getImage();
                },
                child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                        Text(
                          '$ListCnt/3',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ...ImageContainer()
                ],
              )
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
                            borderSide: BorderSide(
                                width: 1, color: Colors.blueAccent))),
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
                    style: const TextStyle(
                      color: Colors.black,
                    ),
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
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
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
