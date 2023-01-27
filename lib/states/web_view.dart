import 'package:flutter/material.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  WebViewController? webViewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse('https://access.amot.in.th/?affiliate=TXpFMU1qQXk'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'Web View',
          textStyle: AppConstant().h2Style(),
        ),
      ),
      body: WebViewWidget(controller: webViewController!),
    );
  }
}
