import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../feautures/auth/providers/auth_provider.dart';
import '../feautures/auth/ui/login_screen.dart';
import '../feautures/home/app_shell.dart';

class FarmersGuideApp extends ConsumerWidget {
  const FarmersGuideApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: authState.when(
        data: (user) {
          if (user == null) return const LoginScreen();
          return const AppShell(); 
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (_, __) => const Scaffold(
          body: Center(child: Text("Auth error")),
        ),
      ),
    );
  }
}
