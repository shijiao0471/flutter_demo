import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new DetailLesson01App());
  }
}

class DetailLesson01App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: new Text(
                    "Sky Space Image",
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                new Text(
                  'Galxy Space',
                  style: new TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text('44')
        ],
      ),
    );

    Column buildButtonColumn(IconData icon, String lable) {
      Color color = Theme
          .of(context)
          .primaryColor;
      return new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Icon(
              icon,
              color: color,
            ),
            new Container(
              margin: const EdgeInsets.only(top: 8),
              child: new Text(
                lable,
                style: new TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: color),
              ),
            )
          ]);
    }

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, "CALL"),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE')
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32),
      child: new Text(
        '''
      Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
      ''',
        softWrap: true,
      ),
    );

    Image imageSection = new Image.asset(
      'images/out_space.jpg',
      height: 240,
      width: 600,
      fit: BoxFit.cover,
    );

    final rowGrid = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new Image.asset(
            'images/out_space.jpg',
            height: 100,
            width: 100,
          ),
          flex: 1,
        ),
        new Expanded(
          child: new Image.asset(
            'images/out_space.jpg',
            height: 100,
            width: 100,
          ),
          flex: 2,
        ),
        new Expanded(
          child: new Image.asset(
            'images/out_space.jpg',
            height: 100,
            width: 100,
          ),
          flex: 1,
        )
      ],
    );

    final listView = new ListView(
      children: <Widget>[
        imageSection,
        titleSection,
        buttonSection,
        textSection,
        rowGrid
      ],
    );
    return _buildStack();
  }

  List<Container> _buildGridTitleList(int count) {
    return new List<Container>.generate(2000, (int index) {
      return new Container(
        // ignore: missing_return
        child: new Image.asset('images/out_space.jpg'),
      );
    });
  }

  Widget buildGrid() {
    return new GridView.extent(
        maxCrossAxisExtent: 150.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _buildGridTitleList(30));
  }

  Widget _buildStack() {
    var stack = new Stack(
      alignment: const Alignment(0.6, 0.6),
      children: <Widget>[
        new CircleAvatar(
          backgroundImage: new AssetImage('images/out_space.jpg'),
          radius: 100,
        ),
        new Container(
          decoration: new BoxDecoration(
              color: Colors.black45
          ),
          child: new Text('Master B', style: new TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
        )
      ],
    );
    return stack;
  }

}
