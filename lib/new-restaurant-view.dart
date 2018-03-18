import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lunch_app_2/base-scaffold.dart';

class NewRestaurantView extends StatelessWidget {
  NewRestaurantView() {
  }

  @override
  Widget build(BuildContext context) {
    return new BaseScaffold(
      title: "Add Restaurant",
      body: new ListView(children: _buildListView(context))
    );
  }

  List<Widget> _buildListView(BuildContext context) {
    return new List.from([
        new ListTile(
          title: new TextField(
            decoration: new InputDecoration(
                hintText: "Name", icon: new Icon(Icons.home)),
          ),
        ),
        new ListTile(
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Description",
              icon: new Icon(Icons.local_dining),
            ),
          ),
        ),
        new ListTile(
          title: new TextField(
              decoration: new InputDecoration(
                hintText: "Address",
                icon: new Icon(Icons.place),
              )),
        ),
        new ListTile(
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Phone Number",
              icon: new Icon(Icons.phone),
            ),
          ),
        ),
        new ListTile(
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Website",
              icon: new Icon(Icons.web),
            ),
          ),
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Okay'),
                color: Colors.blue,
              ),
            ),
            new Expanded(
              child: new RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Back'),
                color: Colors.grey,
              ),
            ),
          ],
        )
    ]);
  }
}