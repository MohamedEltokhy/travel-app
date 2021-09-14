import 'package:flutter/material.dart';

import '../app_data.dart';

class TripDetailScreen extends StatelessWidget {
  static const screenRoute = '/trip-detail';

  final Function manageFavourite;
  final Function isFavorite;
  TripDetailScreen(this.manageFavourite,this.isFavorite);


  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget buildListViewContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      height: 200,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // to get id from that tap when clicked on it
    final tripId = ModalRoute.of(context)!.settings.arguments as String;

    // return data for Trips_data when that id = tripId
    final selectedTrip = Trips_data.firstWhere((trip) => trip.id == tripId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedTrip.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedTrip.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "الانشطة"),
            SizedBox(
              height: 10,
            ),
            buildListViewContainer(
               ListView.builder(
                itemCount: selectedTrip.activities!.length,
                itemBuilder: (ctx, index) => Card(
                  elevation: 0.3,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedTrip.activities![index]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildSectionTitle(context, "البرنامج اليومي"),
            buildListViewContainer(
              ListView.builder(
                itemCount: selectedTrip.program!.length,
                  itemBuilder: (ctx,index) =>Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('يوم${index +1} '),
                        ),
                        title: Text(selectedTrip.program![index]),
                      ),
                      Divider(color: Colors.grey[400],)
                    ],
                  ),
              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isFavorite(tripId) ? Icons.star : Icons.star_border
        ),
        onPressed: (){
          manageFavourite(tripId);
        },
      ),
    );
  }
}
