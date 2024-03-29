import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    // set background
    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/$bgImage'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                  onPressed: () async {
                    // updates data when coming back from choose_location
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text('Edit location',
                      style: TextStyle(
                        color: Colors.grey[300],
                      ))),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Text>[
                  Text(
                    data['location'],
                    style: const TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Text(data['time'],
                  style: const TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
