import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_sd/data/directory/root_directory.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:toast/toast.dart';

class DocumentPage extends StatefulWidget {
  DocumentPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  var rootDirectory;
  Logger logger;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<FileSystemEntity> files = <FileSystemEntity>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (files.length == 0) {
      readDirectory();
    }

    return Scaffold(
      // key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Documents',
        ),
        backgroundColor: Colors.deepOrange,
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
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
          itemCount: files.length,
          itemBuilder: (BuildContext context, int index) {
            final FileSystemEntity fileSystemEntity = files[index];
            final String name = path.basename(fileSystemEntity.path);

            return Container(
              constraints: const BoxConstraints.expand(height: 100),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Container(
                          constraints: const BoxConstraints.expand(width: 72.0),
                          color: Colors.black12,
                        ),
                        Icon(
                          Icons.folder,
                          size: 60.0,
                          color: Colors.deepOrange,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Center(
                      child: Text('$name', style: TextStyle(fontSize: 18.0, color: Colors.deepOrange),),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<void> readDirectory() async {
    var rootDirectory = await getRootDirectory();
    print(rootDirectory);

    final Directory directory = Directory(rootDirectory);
    files = directory.listSync(recursive: false);
    print(files);
    setState(() {
      files;
    });
  }
}
