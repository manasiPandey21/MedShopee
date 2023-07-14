import 'package:epharmacyapp/models/usermodel.dart';
import 'package:epharmacyapp/pages/loading.dart';
import 'package:epharmacyapp/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'controllers/authcontroller.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( ProviderScope(child: MyApp()));
}
class MyApp extends ConsumerWidget {
  UserModel? userModel;

 void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);}
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  return loggedInRoute;
                }
                return loggedOutRoute;
              }),
              routeInformationParser: RoutemasterParser(),
            ),
         error: (error, stackTrace) => ErrorWidget(error.toString()),loading: () => LoadingScreen());
  }
}
