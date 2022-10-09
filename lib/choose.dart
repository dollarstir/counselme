import 'package:flutter/material.dart';

class ChooseCategory extends StatelessWidget {
  final List<String> categories;
  final String category;
  final bool selected;
  final Function(String) onChanged;

  const ChooseCategory({
    @required this.categories,
    @required this.category,
    @required this.onChanged,
    this.selected=false

  });

  @override
  Widget build(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).accentColor : Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: 35,
      width: screenwidth * 0.85,
      margin: EdgeInsets.only(bottom: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconEnabledColor: selected ? Colors.white : Theme.of(context).accentColor,
          dropdownColor: selected ? Colors.grey : Colors.white,
          //iconDisabledColor: Colors.black,
          value: category,
          items: categories
              .map((e) => DropdownMenuItem(
                    child: Row(children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.shuffle,
                        color: selected? Colors.white : Theme.of(context).accentColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        e,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color:  selected ? Colors.white : Colors.grey, fontSize: 11),
                      )
                    ]),
                    value: e,
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}


class ChooseGroup extends StatelessWidget {
  final List<String> groups;
  final String group;
  final bool selectedgroup;
  final Function(String) onChanged;

  const ChooseGroup({
    @required this.groups,
    @required this.group,
    @required this.onChanged,
    this.selectedgroup=false

  });

  @override
  Widget build(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: selectedgroup ? Theme.of(context).accentColor : Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: 35,
      width: screenwidth * 0.85,
      margin: EdgeInsets.only(bottom: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconEnabledColor: selectedgroup ? Colors.white : Theme.of(context).accentColor,
          dropdownColor: selectedgroup ? Colors.grey : Colors.white,
          //iconDisabledColor: Colors.black,
          value: group,
          items: groups
              .map((e) => DropdownMenuItem(
                    child: Row(children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.shuffle,
                        color: selectedgroup? Colors.white : Theme.of(context).accentColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        e,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color:  selectedgroup ? Colors.white : Colors.grey, fontSize: 11),
                      )
                    ]),
                    value: e,
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}


class ChooseLocation extends StatelessWidget {
  final List<String> countries;
  final String country;
  final bool selectedloc;
  final Function(String) onChanged;

  const ChooseLocation({
    @required this.countries,
    @required this.country,
    @required this.onChanged,
    this.selectedloc = false
  });

  @override
  Widget build(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: selectedloc ? Theme.of(context).accentColor : Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: 35,
      width: screenwidth * 0.85,
      margin: EdgeInsets.only(bottom: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconEnabledColor: selectedloc ? Colors.white : Theme.of(context).accentColor,
          dropdownColor: selectedloc ? Colors.grey : Colors.white,
          //iconDisabledColor: Colors.black,
          value: country,
          items: countries
              .map((e) => DropdownMenuItem(
                    child: Row(children: [
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.shuffle,
                        color:  selectedloc ? Colors.white : Theme.of(context).accentColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        e,
                        style: TextStyle(color:  selectedloc ? Colors.white : Colors.grey, fontSize: 11),
                      )
                    ]),
                    value: e,
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
