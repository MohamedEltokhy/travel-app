import 'package:flutter/material.dart';
import 'package:travel_app/widgets/app_drawer.dart';

class FiltersScreen extends StatefulWidget {

  static const screenRoute = '/filters';

  final Function saveFilters;
  final Map<String,bool> currentFilters;

  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _summer = false;
  var _winter = false;
  var _family = false;

  @override
  initState() {
    _summer =widget.currentFilters['summer']??false;
    _winter =widget.currentFilters['winter']??false;
    _family =widget.currentFilters['family']??false;
    super.initState();
  }


  // SwitchListTile buildSwitchListTile(
  //     String title, String subTitle, var currentValue, Function() updateValue) {
  //   return SwitchListTile(
  //     title: Text(title),
  //     subtitle: Text(subTitle),
  //     value: currentValue,
  //     onChanged: updateValue(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الفلترة"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
                final selectedFilters={
                 "summer" : _summer,
                  "winter" : _winter,
                  "family" : _family,
                };
                widget.saveFilters(selectedFilters);
              },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView(
              children: [
                SwitchListTile(
                  title: Text("الرحلات الصيفية فقط"),
                  subtitle: Text("اظهار الرحلات في فصل الصيف فقط"),
                  value: _summer,
                  onChanged: (newValue) {
                     setState(() {
                      _summer = newValue;
                   }
                  );
                },
              ),
                SwitchListTile(
                  title: Text("الرحلات الشتوية فقط"),
                  subtitle: Text("اظهار الرحلات في فصل الشتاء فقط"),
                  value: _winter,
                  onChanged: (newValue) {
                    setState(() {
                      _winter = newValue;
                    }
                    );
                  },
                ),
                SwitchListTile(
                  title: Text("الرحلات العائلية فقط"),
                  subtitle: Text("اظهار الرحلات العائلية فقط"),
                  value: _family,
                  onChanged: (newValue) {
                    setState(() {
                      _family = newValue;
                    }
                    );
                  },
                ),
            ],
          )),
        ],
      ),
    );
  }
}

