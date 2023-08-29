import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu/screen/home_screen.dart';
import 'package:jigu/screen/mypage/mypage_screen.dart';
import 'package:jigu/screen/noticeboard/noticeboard_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
            titleLarge: TextStyle(color: Colors.white.withOpacity(0.8))),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey[850],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.5)
            // selectedLabelStyle: TextStyle(color: Colors.blueGrey[400]),
            // unselectedLabelStyle: const TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[850], elevation: 1), // 같은 색상 사용
        scaffoldBackgroundColor: Colors.grey[850], // 같은 색상 사용
      ),
    );
  }
}
