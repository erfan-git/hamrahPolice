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
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'بستن',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'IranSans',
            ),
          ),
        ),
      ],
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
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _items.length != 0
                            ? Container(
                                height: 150,
                                width: 200,
                                color: Colors.white,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 5,
                                  color: Colors.blue[300],
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: ListTile(
                                      title: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _items[index].subject,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            height: 15,
                                            child: Divider(
                                              color: Colors.white,
                                              height: 10,
                                            ),
                                          ),
                                          Text(
                                            _items[index]
                                                .sendTime
                                                .toString()
                                                .substring(0, 10),
                                            style: TextStyle(
                                              fontFamily: 'IranSans',
                                            ),
                                          ),
                                          Text(
                                            _items[index]
                                                .sendTime
                                                .toString()
                                                .substring(11, 19),
                                            style: TextStyle(
                                              fontFamily: 'IranSans',
                                            ),
                                          ),
                                        ],
                                      ),
                                      leading: Image.network(
                                          'https://images.saymedia-content.com/.image/t_share/MTczODQ5NTg4NjUyODQ0MTY1/10-rappers-with-real-criminal-records.jpg',
                                          height: 250,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              )
                            : Directionality(
                                textDirection: TextDirection.rtl,
                                child: Center(
                                  child: Text(
                                    'موردی یافت نشد',
                                    style: TextStyle(fontFamily: 'IranSans'),
                                  ),
                                ),
                              );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // content: Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   backgroundColor: Colors.white,
    //   body: SafeArea(
    //     child: Directionality(
    //       textDirection: TextDirection.rtl,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Expanded(
    //             child: ListView.builder(
    //               shrinkWrap: true,
    //               itemCount: _items.length,
    //               itemBuilder: (context, index) {
    //                 return Directionality(
    //                   textDirection: TextDirection.rtl,
    //                   child: Column(
    //                     // mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Divider(
    //                         height: 10,
    //                         color: Colors.transparent,
    //                       ),
    //                       ListTile(
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(20),
    //                         ),
    //                         tileColor: Colors.yellow,
    //                         title: Text(_items[index].subject),
    //                         subtitle: Container(
    //                           padding: EdgeInsets.only(top: 5),
    //                         ),
    //                         leading: Container(
    //                           height: 50,
    //                           width: 50,
    //                           // margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
    //                           decoration: BoxDecoration(
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(10)),
    //                             border: Border.all(
    //                               width: 1,
    //                               color: Colors.blue[700],
    //                             ),
    //                           ),
    //                           child: Stack(
    //                             children: [
    //                               Container(
    //                                 width: 45,
    //                                 height: 45,
    //                                 child: ClipRRect(
    //                                     borderRadius: BorderRadius.all(
    //                                         Radius.circular(2)),
    //                                     child: Image.asset(
    //                                       'assets/images/background_main.png',
    //                                       fit: BoxFit.cover,
    //                                     )),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ));
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
