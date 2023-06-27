import 'package:epharmacyapp/pages/authchecker.dart';
import 'package:epharmacyapp/pages/errorpage.dart';
import 'package:epharmacyapp/pages/loading.dart';
import 'package:epharmacyapp/pages/mainpage.dart';
import 'package:epharmacyapp/pages/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

final firebaseinitializedProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializedProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialize.when(
          data: (data) {
            // return const AuthChecker();
            return MainPage();
          },
          error: (e, StackTrace) => ErrorScreen(
                e: e,
                trace: StackTrace,
              ),
          loading: () => LoadingScreen()),
    );
  }
}
