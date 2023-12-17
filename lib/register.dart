import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seblak2/constans.dart';
import 'package:seblak2/firebase_auth_service.dart';
import 'package:seblak2/login.dart';
import 'package:seblak2/launcher.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String username = _usernameController.text;
    String notlpn = _nomorController.text;
    User? user = await _authService.signUpWithEmailandPassword(
        username, notlpn, email, password, context);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User is successfully created"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LauncherPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cannot create user"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo2.png',
                    width: 400, height: 300), // Logo aplikasi
                Text(
                  "Register",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Username",
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextField(
                  controller: _nomorController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Phone Number",
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email Address",
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    hintText: "Password",
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.bg1),
                      onPressed: () {
                        register();
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already has an account?"),
                    const SizedBox(width: 8.0),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: const Text(
                          "Login.",
                          style: TextStyle(color: Color.fromRGBO(158, 0, 0, 1)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
