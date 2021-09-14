import 'package:flutter/material.dart';
import 'package:travel_app/models/trip.dart';
import 'package:travel_app/widgets/trip_item.dart';

class FavouritesScreen extends StatelessWidget {
  // const FavouritesScreen({Key? key}) : super(key: key);

  final List<Trip> favouriteTrips;

  FavouritesScreen(this.favouriteTrips);

  @override
  Widget build(BuildContext context) {
    if(favouriteTrips.isEmpty) {
      return Center(
        child: Text(" ليس لديك اي رحلة في قائمة المفضلة"),
      );
    }
    else{
      return ListView.builder(
        itemBuilder: (ctx,index){
          return TripItem(
            id: favouriteTrips[index].id,
            title: favouriteTrips[index].title,
            imageUrl: favouriteTrips[index].imageUrl,
            duration: favouriteTrips[index].duration,
            tripType: favouriteTrips[index].tripType,
            season: favouriteTrips[index].season,
          //  removeItem: _removeTrip,
          ) ;
        },
        itemCount: favouriteTrips.length,
      );
    }
  }
}
