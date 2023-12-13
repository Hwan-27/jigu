import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jigu/screen/login/login_screen.dart';

class FirebaseService {
  Future<List<Map<String, dynamic>>> getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("NoticeBoardTest").get();

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
}
