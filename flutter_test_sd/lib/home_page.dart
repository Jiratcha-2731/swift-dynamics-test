import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_sd/router/page.dart';
import 'package:toast/toast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromRGBO(245, 245, 245, 0.9),
      appBar: AppBar(
        title: Text('App Test'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Toast.show('on click add button', context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            },
          )
        ],
        backgroundColor: Colors.deepOrange,
      ),
      body: Navigator(key: _navigatorKey, onGenerateRoute: generateRoute),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBody() {
    List _drawerItems = [
      {"icon": Icons.create, "name": "Change Events"},
      {"icon": Icons.insert_drive_file, "name": "Prime Contracts"},
      {"icon": Icons.timelapse, "name": "T&M ticket"},
      {"icon": Icons.assignment, "name": "Daily Log"},
      {"icon": Icons.contacts, "name": "Directory"},
      {"icon": Icons.folder_open, "name": "Documents"},
      {"icon": Icons.image_aspect_ratio, "name": "Drawing"},
      {"icon": Icons.description, "name": "Forms"},
      {"icon": Icons.check_box, "name": "Inspection"},
      {"icon": Icons.supervisor_account, "name": "Meeting"},
    ];

    return GridView.builder(
      itemCount: _drawerItems.length,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        Map item = _drawerItems[index];
        return GestureDetector(
          onTap: () {
            if(item['name'] == 'Forms'){
              Navigator.of(scaffoldKey.currentContext).pushNamed(Pages.form);
            }
            else if (item['name'] == 'Documents'){
              Navigator.of(scaffoldKey.currentContext).pushNamed(Pages.document);
            }
            else{
              Toast.show(item['name'], context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
          },
          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item['icon'],
                  color: Colors.deepOrange,
                  size: 50.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  item['name'],
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black87,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      currentIndex: _currentIndex,
      onTap: (value) {
        // Respond to item press.
        switch (value) {
          case 0:
            _navigatorKey.currentState.pushReplacementNamed("Tool");
            break;
          case 1:
            _navigatorKey.currentState.pushReplacementNamed("Drawings");
            break;
          case 2:
            _navigatorKey.currentState.pushReplacementNamed("Dashboard");
            break;
          case 3:
            _navigatorKey.currentState.pushReplacementNamed("Setting");
            break;
        }
        setState(() => _currentIndex = value);
      },
      items: [
        BottomNavigationBarItem(
          title: Text('Tools'),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text('Drawings'),
          icon: Icon(Icons.image),
        ),
        BottomNavigationBarItem(
          title: Text('Dashboard'),
          icon: Icon(Icons.pie_chart),
        ),
        BottomNavigationBarItem(
          title: Text('Setting'),
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "Drawings":
        return MaterialPageRoute(
            builder: (context) => Container(
                color: Colors.white,
                child: Center(
                    child: Text(
                  "Drawings",
                  style: TextStyle(fontSize: 20.0),
                ))));
      case "Dashboard":
        return MaterialPageRoute(
            builder: (context) => Container(
                color: Colors.black12,
                child: Center(child: Text("Dashboard", style: TextStyle(fontSize: 20.0),))));
      case "Setting":
        return MaterialPageRoute(
            builder: (context) => Container(
                color: Colors.black45, child: Center(child: Text("Settings", style: TextStyle(fontSize: 20.0),))));
      default:
        return MaterialPageRoute(builder: (context) => _buildBody());
    }
  }
}
