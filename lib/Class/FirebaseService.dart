import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jigu/screen/login/login_screen.dart';

class FirebaseService {
  Future<List<Map<String, dynamic>>> getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("NoticeBoard").get();

    List<Map<String, dynamic>> dataList = [];

    for (var document in snapshot.docs) {
      if (document.exists) {
        Map<String, dynamic> data = document.data();

        dataList.add(data);
      }
    }
    print(dataList);
    return dataList;
  }

  Future<void> PutData(
      String title, String content, String imageUrl, String userid) async {
    await firestore.collection('NoticeBoard').add({
      'title': title,
      'content': content,
      'image': imageUrl,
      'userid': userid,
      'IN_DT': DateTime
    });
  }
}
