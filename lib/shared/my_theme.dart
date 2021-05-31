part of 'shared.dart';

class MyTheme{

  static ThemeData lightTheme(){
    return ThemeData(
      //harus menggunakan color yang tidak ada adjustnya
      primarySwatch: Colors.amber,
      // harus 0xFF awalannya
      backgroundColor: Color(0xFFf2f2f2),
      primaryColor: Colors.deepPurple,
      accentColor:Colors.deepOrange[400],
      //auto harmoni
      visualDensity:  VisualDensity.adaptivePlatformDensity,
      brightness:  Brightness.light,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }

  static ThemeData darkTheme(){
    return ThemeData(
      //harus menggunakan color yang tidak ada adjustnya
      primarySwatch: Colors.amber,
      // harus 0xFF awalannya
      backgroundColor: Color(0xFF262626),
      primaryColor: Colors.deepOrange[400],
      accentColor:Colors.deepOrange[400],
      //auto harmoni
      visualDensity:  VisualDensity.adaptivePlatformDensity,
      brightness:  Brightness.dark,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }
}