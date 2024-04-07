import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:cb/screens/add_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = true;
  String? errorMessage = '';

  @override
  Widget build(BuildContext context) {
    Future<bool> signInWithEmailAndPassword() async {
      try {
        await CustomFireBaseAuth().signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        return true;
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
        return false;
      }
    }

    Future<bool> createUserWithEmailAndPassword() async {
      try {
        await CustomFireBaseAuth().createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        return true;
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool isSuccessfulLogin = await signInWithEmailAndPassword();
                    if (isSuccessfulLogin) {
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const AddData(),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (emailController.text != '' ||
                        emailController.text.isNotEmpty) {
                      bool isSuccessfulLogin =
                          await createUserWithEmailAndPassword();
                      if (isSuccessfulLogin) {
                        if (context.mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const AddData(),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              errorMessage == '' ? '' : 'Error: $errorMessage',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
