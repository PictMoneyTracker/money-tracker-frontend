import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StockWebView extends StatefulWidget {
  const StockWebView({
    Key? key,
    required this.stockSymbol,
  }) : super(key: key);

  final String stockSymbol;

  @override
  State<StockWebView> createState() => _StockWebViewState();
}

class _StockWebViewState extends State<StockWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(
            "https://in.tradingview.com/chart/?symbol=NSE%3A${widget.stockSymbol}"),
      )..setJavaScriptMode(JavaScriptMode.unrestricted)..enableZoom(true);
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stockSymbol),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
