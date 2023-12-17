import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seblak2/firebase_auth_service.dart';
import 'package:seblak2/register.dart';
import 'package:seblak2/launcher.dart';
import 'package:seblak2/constans.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user =
        await _authService.loginWithEmailandPassword(email, password, context);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login succes"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => LauncherPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login failed"),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo2.png',
                  width: 400, height: 300), // Logo aplikasi
              const SizedBox(height: 20.0),
              Text(
                "Login to continue",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20.0,
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
                      login();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account?"),
                  const SizedBox(width: 4.0),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: const Text(
                        "Register.",
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
