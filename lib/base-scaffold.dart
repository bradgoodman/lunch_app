import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BaseScaffold extends Scaffold {
  BaseScaffold({ @required String title, @required Widget body, Widget floatingActionButton })
    : super(
      appBar : _buildAppBar(title),
      drawer : _buildDrawer(),
      body : body,
      floatingActionButton : floatingActionButton
  );

  static AppBar _buildAppBar(String title) {
    return new AppBar(title: new Text(title));
  }

  static Drawer _buildDrawer() {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              accountName: const Text('John Doe'),
              accountEmail: const Text('john.doe@gmail.com'),
              currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.white, child: new Text('John'))),
          new ListTile(
            title: new Text('Nearby'),
            leading: new Icon(Icons.near_me),
            onTap: null,
          ),
          new ListTile(
            title: new Text('Order'),
            leading: new Icon(Icons.restaurant_menu),
            onTap: null,
          ),
          new ListTile(
            title: new Text('Search'),
            leading: new Icon(Icons.search),
            onTap: null,
          ),
          new ListTile(
            title: new Text('Settings'),
            leading: new Icon(Icons.settings),
            onTap: null,
          ),
          new Divider(),
          new ListTile(
            title: new Text('Log Out'),
            leading: new Icon(Icons.exit_to_app),
            onTap: null,
          )
        ],
      ),
    );
  }
}