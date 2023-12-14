import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSchemeSeed = Color.fromARGB(255, 39, 68, 98);
const scaffoldBackgroundColor = Color.fromARGB(255, 249, 238, 196);

class AppTheme {
  ThemeData getTheme() =>
      ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: colorSchemeSeed,
        
      
      brightness: Brightness.light,
      
      //TEXT TYPES:
      textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 40, fontWeight: FontWeight.bold , color: Colors.white),
      titleMedium: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 30, fontWeight: FontWeight.bold  , color: Colors.white ),
      titleSmall: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 20  , color: Colors.white )
    ),

    //SCAFFOLD COLOR:
    scaffoldBackgroundColor: scaffoldBackgroundColor,

    //BUTTON COLOR:
    buttonTheme: const ButtonThemeData(
      buttonColor: colorSchemeSeed,
      textTheme: ButtonTextTheme.primary
    )
      
      );
}
