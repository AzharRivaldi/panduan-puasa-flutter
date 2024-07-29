import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:panduan_puasa/page_detail/detail_penjelasan_page.dart';
import 'package:panduan_puasa/page_ramadhan/model_ramadhan.dart';

class RamadhanPage extends StatefulWidget {
  final String strTitle;

  const RamadhanPage({super.key, required this.strTitle});

  @override
  State<RamadhanPage> createState() => DetailRamadhanState();
}

class DetailRamadhanState extends State<RamadhanPage> {
  String? strTitle;

  @override
  initState() {
    super.initState();
    strTitle = widget.strTitle;
  }

  //method get data
  Future<List<ModelRamadhan>> readJsonData() async {
    final jsonData = await rootBundle.rootBundle.loadString('assets/data/puasa_ramadhan.json');
    final listData = json.decode(jsonData) as List<dynamic>;
    return listData.map((e) => ModelRamadhan.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            strTitle.toString(),
            maxLines: 2,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: readJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(
                      child: Text("${data.error}")
                  );
                } else if (data.hasData) {
                  var items = data.data as List<ModelRamadhan>;
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPenjelasanPage(
                                    strTitle: items[index].title.toString(),
                                    strContent: items[index].description.toString()
                                ),
                              ),
                            );
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
          ),
        ],
      ),
    );
  }
}

