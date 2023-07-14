import 'package:epharmacyapp/pages/home.dart';
import 'package:epharmacyapp/pages/signIn.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute =
    RouteMap(routes: {'/': (_) => MaterialPage(child: SignIn())});

    final loggedInRoute =
    RouteMap(routes: {'/': (_) => MaterialPage(child: Home())});
