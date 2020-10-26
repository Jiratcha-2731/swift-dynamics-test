import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_sd/router/router.dart';
import 'package:logging/logging.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() : _router = Router() {
    initLogger();
  }
  final Router _router;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: MaterialApp(
          title: 'KAYA',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          home: MyHomePage(title: 'KAYA'),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: _router.getRoute,
          navigatorObservers: <RouteObserver<PageRoute<dynamic>>>[
            _router.routeObserver
          ],
        ));
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord record) {
      final dynamic e = record.error;
    });
    Logger.root.info('Logger initialized.');
  }
}