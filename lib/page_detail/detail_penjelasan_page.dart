import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPenjelasanPage extends StatefulWidget {
  final String strTitle, strContent;

  const DetailPenjelasanPage({super.key, required this.strTitle, required this.strContent});

  @override
  State<DetailPenjelasanPage> createState() => DetailPenjelasanPageState();
}

class DetailPenjelasanPageState extends State<DetailPenjelasanPage> {
  String? strTitle, strContent;
  late final WebViewController controller;

  @override
  initState() {
    super.initState();
    strTitle = widget.strTitle;
    strContent = widget.strContent;

    //webview controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..loadHtmlString(
        strContent.toString(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

