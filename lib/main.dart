import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favoritewidget.dart';

void main() {
  runApp(new MaterialApp(title: "Whats for Lunch?", home: new LandingPage()));
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildWidget(
        {String title,
        String description,
        String address,
        String url,
        String phoneNumber}) {
      return new ListTile(
          title: new Text(title),
          subtitle: new Text(description),
          onTap: () {
            return showDialog<Null>(
                context: context,
                child: new SimpleDialog(
                    title: new Text(title + ":"),
                    children: <Widget>[
                      new ListTile(
                        leading: new Icon(Icons.place),
                        title: new Text('Address'),
                        subtitle: new Text(address),
                      ),
                      new ListTile(
                        leading: new Icon(Icons.local_phone),
                        title: new Text('Phone Number'),
                        subtitle: new Text(phoneNumber),
                        onTap: _launchCall,
                      ),
                      new ListTile(
                        leading: new Icon(Icons.launch),
                        title: new Text('Website'),
                        subtitle: new Text(url),
                        onTap: _launchURL,
                      ),
                      new ButtonTheme.bar(
                          child: new ButtonBar(
                        children: <Widget>[
                          new FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Okay')),
                        ],
                      ))
                    ]));
          },
          trailing: new FavoriteWidget());
    }

    List<Widget> _buildRestaurantsListView() {
      List<Widget> listWidgets = new List();
      listWidgets.add(_buildWidget(
        title: "Bellacinos",
        description: "Sandwhiches and Pizza",
        address: "11249 St Charles Rock Rd, Bridgeton, MO 63044",
        url: "http://bellacinosgrinders.com",
        phoneNumber: "(314) 736-5055",
      ));
      listWidgets.add(_buildWidget(
          title: "Imo's",
          description: 'St. Louis Style Pizza',
          address: "510 Airport Rd, Ferguson, MO 63135",
          url: "https://www.imospizza.com",
          phoneNumber: "(314) 427-4141"));
      listWidgets.add(_buildWidget(
          title: 'Jack In The Box',
          description: 'Tacos & Burgers',
          address: "9707 Natural Bridge Rd, Berkeley, MO 63134",
          url: "https://www.jackinthebox.com",
          phoneNumber: "(314) 423-0244"));
      listWidgets.add(_buildWidget(
          title: 'Jimmy Johns',
          description: 'Sandwiches',
          address: "11905 St Charles Rock Rd, Bridgeton, MO 63044",
          url: "https://www.jimmyjohns.com",
          phoneNumber: "(314) 770-9991"));
      listWidgets.add(_buildWidget(
          title: 'McDonalds',
          description: 'Burgers',
          address: "1790 S Florissant Rd, St. Louis, MO 63121",
          url: "https://www.mcdonalds.com",
          phoneNumber: "(314) 521-1062"));
      listWidgets.add(_buildWidget(
          title: 'Papa Johns',
          description: 'Pizza',
          address: "417 S Florissant Rd, Ferguson, MO 63135",
          url: "https://www.papajohns.com",
          phoneNumber: "(314) 521-1062"));
      listWidgets.add(_buildWidget(
          title: 'Pearl Cafe',
          description: 'Thai Food',
          address: "8416 N Lindbergh Blvd, Florissant, MO 63031",
          url: "http://pearlstl.com",
          phoneNumber: "(314) 831-3701"));
      listWidgets.add(_buildWidget(
          title: 'Seoul Taco',
          description: 'Korean Street Food',
          address: "6665 Delmar Blvd, St. Louis, MO 63130",
          url: "http://www.seoultaco.com",
          phoneNumber: "(314) 863-1148"));
      listWidgets.add(_buildWidget(
          title: 'Whistle Stop',
          description: 'Sandwiches',
          address: "1 Carson Rd, Ferguson, MO 63135",
          url: "http://www.fergusonwhistlestop.com/",
          phoneNumber: "(314) 521-1600"));
      listWidgets.add(_buildWidget(
          title: 'White Castle',
          description: 'Sliders',
          address: "9301 Natural Bridge Rd, Berkeley, MO 63134",
          url: "https://www.whitecastle.com",
          phoneNumber: "(314) 427-5773"));
      return listWidgets;
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Restaraunts'),
        ),
        body: new ListView(
          children: _buildRestaurantsListView(),
        ),
        drawer: new Drawer(
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
        ),
        floatingActionButton: new FloatingActionButton(
            tooltip: 'Add',
            child: new Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  child: new Card(
                      child: new Column(
                    children: <Widget>[
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
                    ],
                  )));
            }));
  }
}

_launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchCall() async {
  const call = 'tel: 314-449-2532';
  if (await canLaunch(call)) {
    await launch(call);
  } else {
    throw 'Could not $call phone number';
  }
}
