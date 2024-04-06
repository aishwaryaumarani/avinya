import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RatesWidgets extends StatefulWidget {
  final Widget Function(RateMyApp) builder;
  const RatesWidgets({super.key, required this.builder});

  @override
  State<RatesWidgets> createState() => _RatesWidgetsState();
}

class _RatesWidgetsState extends State<RatesWidgets> {
  RateMyApp? rateMyApp;
  @override
  Widget build(BuildContext context) {
    return RateMyAppBuilder(
      rateMyApp: RateMyApp(
        googlePlayIdentifier: "com.bussiness.esparse_solution"
      ),
      onInitialized: (context, rateMyApp) {
        setState(() {
          this.rateMyApp = rateMyApp;
        });
      },
      builder: (context) => rateMyApp ==null
        ?Center(child: CircularProgressIndicator())
        : widget.builder(rateMyApp!),
    );
  }
}