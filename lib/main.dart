import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_app/app_data.dart';
import 'package:travel_app/screens/categories_screen.dart';
import 'package:travel_app/screens/category_trips_screen.dart';
import 'package:travel_app/screens/filters_screen.dart';
import 'package:travel_app/screens/tabs_screen.dart';
import 'package:travel_app/screens/trip_detail_screen.dart';

import 'models/trip.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{

  Map<String ,bool> _filters ={
    'summer' : false,
    'winter' : false,
    'family' : false,
  };

  List<Trip> _availableTrips=Trips_data;
  List<Trip> _favouriteTrips=[];

  void _changeFilters(Map<String,bool> filterDate){
    setState(() {
      _filters = filterDate;

      _availableTrips =Trips_data.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _manageFavorite(String tripId){
    final existingIndex =_favouriteTrips.indexWhere((trip) => trip.id == tripId);
    if(existingIndex >= 0){
      setState(() {
        _favouriteTrips.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favouriteTrips.add(
            Trips_data.firstWhere((trip) => trip.id == tripId)
        );
      });
    }

  }

  bool _isFavorite(String id){
    return _favouriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // English, no country code
      ],
      title: 'دليل سياحي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink[900],
        accentColor: Colors.pink[400],
        fontFamily: 'ElMessiri',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline5: TextStyle(
            color: Colors.pink[100],
            fontSize: 24,
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.bold
          ),
          headline6: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':(ctx)=>TabsScreen(_favouriteTrips),
        CategoryTripsScreen.screenRoute: (ctx)=>CategoryTripsScreen(_availableTrips),
        TripDetailScreen.screenRoute:(ctx)=>TripDetailScreen(_manageFavorite,_isFavorite),
        FiltersScreen.screenRoute:(ctx)=>FiltersScreen(_filters,_changeFilters),
      },
    );
  }
}
