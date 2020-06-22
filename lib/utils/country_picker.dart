import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:diacritic/diacritic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:insta_cyber/generated/l10n.dart';
import 'package:insta_cyber/utils/language_utils.dart';

const _platform = const MethodChannel('biessek.rocks/flutter_country_picker');

Future<List<Country>> _fetchLocalizedCountryNames() async {
  List<Country> renamed = new List();
  Map result;
  try {
    var isoCodes = <String>[];
    Country.ALL.forEach((Country country) {
      isoCodes.add(country.isoCode);
    });
    result = await _platform.invokeMethod('getCountryNames', <String, dynamic>{'isoCodes': isoCodes});
  } on PlatformException catch (e) {
    return Country.ALL;
  }

  for (var country in Country.ALL) {
    renamed.add(country.copyWith(name: result[country.isoCode]));
  }
  renamed.sort(
          (Country a, Country b) => removeDiacritics(a.name).compareTo(b.name));

  return renamed;
}

class CustomCountryDialog extends StatefulWidget {
  final bool number;
  const CustomCountryDialog({
    this.number,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomCountryDialogState();
}

class _CustomCountryDialogState extends State<CustomCountryDialog> {
  TextEditingController controller = new TextEditingController();
  String filter;
  List<Country> countries;

  @override
  void initState() {
    super.initState();

    countries = Country.ALL;

    _fetchLocalizedCountryNames().then((renamed) {
      setState(() {
        countries = renamed;
        countries = countries.where((x) => LanguageUtils.list.any((y) => x.isoCode.toLowerCase()==y["code"].toLowerCase())).toList();
      });
    });

    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Row(
              children: <Widget>[
                new Text(widget.number ? S.of(context).selectCountry.toUpperCase() : S.of(context).selectLanguage.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  height: 1.0,
                  color: Hexcolor("#dbdbdb"),
                ),
              )
            ],
          ),
          new TextField(
            decoration: new InputDecoration(
              hintText: MaterialLocalizations.of(context).searchFieldLabel,
              prefixIcon: Icon(Icons.search),
              suffixIcon: filter == null || filter == ""
                  ? Container(
                height: 0.0,
                width: 0.0,
              )
                  : InkWell(
                child: Icon(Icons.clear),
                onTap: () {
                  controller.clear();
                },
              ),
            ),
            controller: controller,
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (BuildContext context, int index) {
                  Country country = countries[index];
                  if (filter == null ||
                      filter == "" ||
                      country.name
                          .toLowerCase()
                          .contains(filter.toLowerCase()) ||
                      country.isoCode.contains(filter)) {
                    return InkWell(
                      child: widget.number ? ListTile(
                        title: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  country.name + " (+${country.dialingCode})",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ) : ListTile(
                        //trailing: Text("+ ${country.dialingCode}"),
                        title: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  LanguageUtils.getNativeNameFromCode(country.isoCode.toLowerCase()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  country.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context, country);
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
