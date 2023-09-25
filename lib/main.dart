import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jigu/screen/home_screen.dart';
import 'package:jigu/screen/mypage/mypage_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core 패키지
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 초기화

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: const FirebaseOptions(
    //   apiKey: "AIzaSyAd_SLEOBI-siiPSTSa5HeZe6CnV-VpHnU",
    //   authDomain:
    //       "180356464308-95g0qdt944m7on819gi3u0pa4hjhsr6m.apps.googleusercontent.com",
    //   projectId: "jigu-h",
    //   storageBucket: "gs://jigu-h.appspot.com",
    //   messagingSenderId: "180356464308",
    //   appId: "1:180356464308:android:5729fb059ec21de67861e1",
    //   measurementId: "YOUR_MEASUREMENT_ID",
    // ),
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Firebase 초기화가 완료되면 토스트 메시지를 표시
    Firebase.initializeApp().then((value) {
      Fluttertoast.showToast(
        msg: 'Firebase 연결 성공',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
        backgroundColor: Colors.green, // Firebase 초기화 성공 시 적절한 색상으로 변경
        textColor: Colors.white,
      );
    });

    return GetMaterialApp(
      initialRoute: '/', // 초기 라우트를 홈 화면으로 설정
      routes: {
        '/': (context) => const HomeScreen(), // 홈 화면에 대한 라우트
        '/mypage': (context) => const MypageScreen(),
        // 다른 라우트 추가 가능
      },
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white.withOpacity(0.8)),
          bodyMedium: TextStyle(color: Colors.white.withOpacity(1)),
          titleLarge: TextStyle(color: Colors.white.withOpacity(0.8)),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[850],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          elevation: 1,
        ),
        scaffoldBackgroundColor: Colors.grey[850],
      ),
    );
  }
}
