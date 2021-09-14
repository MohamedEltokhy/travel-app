import 'package:flutter/material.dart';
import 'package:travel_app/models/trip.dart';
import 'package:travel_app/screens/categories_screen.dart';
import 'package:travel_app/screens/favourites_screen.dart';
import 'package:travel_app/widgets/app_drawer.dart';


class TabsScreen extends StatefulWidget {

  final List<Trip> favouriteTrips;

  TabsScreen(this.favouriteTrips);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int _selectedScreenIndex =0;

  void _selectScreen(int index){
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  List<Map<String,dynamic>> _screens= [];

  @override
  void initState() {
    _screens=[
      {
        "Screen":CategoriesScreen(),
        "title":"تصنيفات الرحلات"
      },
      {
        "Screen":FavouritesScreen(widget.favouriteTrips),
        "title":"الرحلات المفضلة"
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]['title']),
      ),
      drawer: AppDrawer(),
      body: _screens[_selectedScreenIndex]['Screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "التصنيفات"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "المفضلة"
          ),
        ],
      ),
    );
  }
}



// top tapBar
// import 'package:flutter/material.dart';
// import 'package:travel_app/screens/favourites_screen.dart';
//
// import 'categories_screen.dart';
// class TabsScreen extends StatelessWidget {
//   const TabsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title:Text("دليل سياحي"),
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.dashboard),
//                   text: 'التصنيفات',
//                 ),
//                 Tab(
//                   icon: Icon(Icons.star),
//                   text: 'المفضلة',
//                 ),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               CategoriesScreen(),
//               FavouritesScreen(),
//             ],
//           ),
//         )
//     );
//   }
// }
