import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:panduan_puasa/page_detail/detail_penjelasan_page.dart';
import 'package:panduan_puasa/page_ramadhan/page_ramadhan.dart';
import 'package:panduan_puasa/page_sunnah/page_sunnah.dart';
import 'model_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //method get data
  Future<List<ModelHome>> readJsonData() async {
    final jsonData = await rootBundle.rootBundle.loadString('assets/data/penjelasan_puasa.json');
    final listData = json.decode(jsonData) as List<dynamic>;
    return listData.map((e) => ModelHome.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assalamualaikum,",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Text(
              "Azhar Rivaldi",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Image.asset(
              'assets/images/ic_profile.png',
              height: 50,
              width: 50,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Image(
                      height: 220,
                      image: AssetImage('assets/images/pic_puasa.jpg'),
                      fit: BoxFit.fill,
                    )
                )
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 0, 0, 10),
              child: Text(
                "Penjelasan Puasa",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
            ),
            FutureBuilder(
              future: readJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(
                      child: Text("${data.error}")
                  );
                } else if (data.hasData) {
                  var items = data.data as List<ModelHome>;
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            String strTitle = items[index].title.toString();
                            String strContent = items[index].description.toString();

                            if (items[index].title == 'Puasa Ramadhan') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RamadhanPage(
                                    strTitle: strTitle
                                  ),
                                ),
                              );
                            } else if (items[index].title == 'Puasa Sunnah') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SunnahPage(
                                    strTitle: strTitle
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPenjelasanPage(
                                      strTitle: strTitle,
                                      strContent: strContent
                                  ),
                                ),
                              );
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(
                                "${index + 1}. ${items[index].title}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

