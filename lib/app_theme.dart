import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final Color primaryColor = Color(0xFF5D9CEC);
  static final Color whiteColor = Color(0xFFFFFFFF);
  static final Color darkColor = Color(0xFF141922);
  static final Color lightColor = Color(0xFFA9A9A9);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFDFECDB),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: whiteColor
      )
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: whiteColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: whiteColor,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darkColor,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: darkColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: darkColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: darkColor,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.symmetric(horizontal: 0),
      shape: CircularNotchedRectangle(),
      elevation: 0,
      color: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: whiteColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: lightColor,
        showSelectedLabels: false,
        showUnselectedLabels: false),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 4, color: whiteColor),
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
    ),
    cardTheme: CardTheme(
      color: whiteColor,
    )
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF060E1E),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
        iconTheme: IconThemeData(
            color: darkColor
        )
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: darkColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: whiteColor,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: whiteColor,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: whiteColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: whiteColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: whiteColor,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.symmetric(horizontal: 0),
      shape: CircularNotchedRectangle(),
      elevation: 0,
      color: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: darkColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: whiteColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 4, color: darkColor),
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
    ),
      cardTheme: CardTheme(
          color: darkColor
      )
  );
}
