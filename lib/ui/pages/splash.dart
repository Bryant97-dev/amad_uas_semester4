part of  'pages.dart';

class  Splash extends StatefulWidget {
  static const String routeName = "/splash";
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  _loadSplash() async{
    var _duration = Duration(seconds: 3);
    return Timer(_duration,checkAuth);
  }

  void checkAuth(){
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null){
      Navigator.pushReplacementNamed(context, MainMenu.routeName);
      ActivityServices.showToast("Welcome Back"+auth.currentUser.email, Colors.blue);
    }else{
      Navigator.pushReplacementNamed(context, Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
        alignment: Alignment.center,
        child:Column(
          children: [
            Image.asset("assets/images/logo.png", height: 400
            ),
            Text("DOKUMENKU", style: TextStyle(
                fontSize: 24,
                color: Colors.white ,
                fontStyle: FontStyle.italic,
            )),
          ]
        )
      ),
    );
  }
}
