import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu/screen/login/login_forget_screen.dart';
import 'package:jigu/screen/login/login_tos_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core 패키지
import 'package:google_sign_in/google_sign_in.dart'; // Google Sign-In 패키지

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _outoLogin = false;
  bool _outoId = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //키보드 내리기
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("로그인"),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      "images/jigu5.png", // Image 기존 jigu3 흰 배경 지우고 로고만 남겨놓은 jigu5.Png파일로 변경
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "전화번호 또는 이메일",
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.5))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.blue)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    //비밀번호 안보이게 설정
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "비밀번호",
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.5))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.5))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue))),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: CheckboxListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            controlAffinity: ListTileControlAffinity.leading,
                            visualDensity: const VisualDensity(
                                vertical: -4, horizontal: -4),
                            title: const Text(
                              "자동 로그인",
                              style: TextStyle(color: Colors.white),
                            ),
                            value: _outoLogin,
                            onChanged: (bool? value) {
                              setState(() {
                                _outoLogin = value!;
                              });
                            }),
                      ),
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: CheckboxListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            controlAffinity: ListTileControlAffinity.leading,
                            visualDensity: const VisualDensity(
                                vertical: -4, horizontal: -4),
                            title: const Text(
                              "아이디 저장",
                              style: TextStyle(color: Colors.white),
                            ),
                            value: _outoId,
                            onChanged: (bool? value) {
                              setState(() {
                                _outoId = value!;
                              });
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("로그인", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white),
                      child: Row(
                        children: [
                          Image.asset('images/google.png'),
                          const SizedBox(
                            width: 110,
                          ),
                          const Text("구글계정으로 로그인",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LoginForgetScreen());
                    },
                    child: const Text("아이디 / 비밀번호를 잊으셨나요?"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("지구가 처음이신가요? "),
                      TextButton(
                        onPressed: () => Get.to(() => const LoginTosScreen()),
                        child: const Text("가입하기"),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Future<User?> signInWithGoogle() async {
    try {
      print('구글계정 로그인');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; // 사용자가 로그인을 취소한 경우
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      print('로그인 오류: $error');
      return null;
    }
  }
}
