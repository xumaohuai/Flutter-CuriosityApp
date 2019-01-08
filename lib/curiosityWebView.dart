import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CuriosityWebView extends StatefulWidget {
  @override
  String htmlBody;
  CuriosityWebView({Key key, @required this.htmlBody}) : super(key: key);
  _CuriosityWebViewState createState() => _CuriosityWebViewState();
}

class _CuriosityWebViewState extends State<CuriosityWebView> {
  String htmlBody = '';
  @override
  void initState() {
    super.initState();
    htmlBody = widget.htmlBody.replaceAll( '/assets/app3','http://app3.qdaily.com/assets/app3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('网页详情'),
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: WebviewScaffold(url: htmlBody),
      ),
    );
  }

}
