import 'package:epharmacyapp/pages/home.dart';
import 'package:epharmacyapp/pages/signIn.dart';
import 'package:epharmacyapp/providers/auth_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'errorpage.dart';
import 'loading.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
        data: (data) {
          if (data != null) return Home();
          return SignIn();
        },
        error: (e, StackTrace) => ErrorScreen(
              e: e,
              trace: StackTrace,
            ),
        loading: () => LoadingScreen());
  }
}
