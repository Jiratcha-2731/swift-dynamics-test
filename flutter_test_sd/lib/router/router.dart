import 'package:flutter/material.dart';
import 'package:flutter_test_sd/document_page.dart';
import 'package:flutter_test_sd/form_page.dart';
import 'package:flutter_test_sd/home_page.dart';
import 'package:flutter_test_sd/router/page.dart';

class Router {
  Router() : routeObserver = RouteObserver<PageRoute<dynamic>>();

  final RouteObserver<PageRoute<dynamic>> routeObserver;

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.home:
        return _buildRoute(settings, MyHomePage());
      case Pages.form:
        return _buildRoute(settings, FormPage());
      case Pages.document:
        return _buildRoute(settings, DocumentPage());
      default:
        return null;
    }
  }

  MaterialPageRoute<dynamic> _buildRoute(
      RouteSettings settings, Widget builder) {
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (BuildContext ctx) => builder,
    );
  }
}