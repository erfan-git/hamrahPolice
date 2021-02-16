import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamrahpolice1/model/report.dart';
import 'package:http/http.dart';

class ReportList extends StatefulWidget {
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  List<Report> _items = List();

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(
          child: Text(
            'لیست گزارشات',
            style: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'IranSans',
            ),
          ),
        ),
        content: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(
                                height: 10,
                                color: Colors.transparent,
                              ),
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                tileColor: Colors.yellow,
                                title: Text(_items[index].subject),
                                subtitle: Container(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  // margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 45,
                                        height: 45,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2)),
                                            child: Image.asset(
                                              'assets/images/background_main.png',
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      //     : Container(
                                      //   width: 250,
                                      //   height: 250,
                                      //   child: Icon(
                                      //     Icons.camera_alt,
                                      //     size: 90,
                                      //     color: Colors.blue[900],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future fetchItems() async {
    var url = "http://10.0.2.2:8000/api/reports/";
    Response response = await get(url);
    print(response.statusCode);
    setState(() {
      // var productJson = json.decode(utf8.decode(response.bodyBytes));
      var productJson = json.decode(response.body);
      for (var i in productJson) {
        var reportItem = Report(
            i['subject'], i['image'], i['lat'], i['lan'], i['created_at']);
        _items.add(reportItem);
      }
    });
  }
}
