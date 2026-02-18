import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agromate/features/auth/providers/auth_provider.dart';
import 'package:agromate/features/auth/ui/login_screen.dart';
import 'package:agromate/features/home/app_shell.dart' as shell;


class AgromateApp extends ConsumerWidget {
  const AgromateApp ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: authState.when(
        data: (user) {
          if (user == null) return const LoginScreen();
return const shell.AppShell();

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
