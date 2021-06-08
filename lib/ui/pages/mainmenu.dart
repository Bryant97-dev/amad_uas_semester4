part of 'pages.dart';

class MainMenu extends StatefulWidget {
  static const String routeName = "/mainmenu";
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions =  <Widget>[
    ListData(),
    AddData(),
    MyAccount(),
    ListPins(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void InitState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  Center(
        child: _widgetOptions.elementAt(_selectedIndex),
    ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_rounded),
            label: "List data",
          ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_add_rounded),
              label: "Add data",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "My account",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.push_pin),
            label: "List Pins",
          ),
        ],
        currentIndex: _selectedIndex,
          onTap: _onItemTapped,
      ) ,
    );
  }
}
