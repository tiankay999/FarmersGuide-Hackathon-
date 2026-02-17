import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_repository_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool loading = false;
  String? error;

Future<void> signup() async {
  setState(() {
    loading = true;
    error = null;
  });

  try {
    await ref.read(authRepositoryProvider).signUp(
          email: emailCtrl.text.trim(),
          password: passCtrl.text.trim(),
        );

    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    error = e.message;
    debugPrint("FIREBASE SIGNUP ERROR: ${e.code}");
  } catch (e) {
    error = "Unknown error occurred";
    debugPrint("UNKNOWN SIGNUP ERROR: $e");
  }

  setState(() => loading = false);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Create Account", style: TextStyle(fontSize: 24)),

            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 20),

            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),

            ElevatedButton(
              onPressed: loading ? null : signup,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
