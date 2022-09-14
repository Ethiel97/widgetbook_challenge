import 'package:flutter/material.dart';

///creating a high-level widget to abstract business logic
abstract class WidgetView<T1 extends StatefulWidget, T2 extends State<T1>>
    extends StatelessWidget {
  ///constructor
  const WidgetView(this.state, {Key? key}) : super(key: key);

  ///state to hold business logic
  final T2 state;

  ///getter to access state
  T1 get widget => state.widget;

  @override
  Widget build(BuildContext context);
}

///
abstract class StatelessView<T1 extends Widget> extends StatelessWidget {
  ///  Creates a new instance of [StatelessView].
  const StatelessView(this.widget, {Key? key}) : super(key: key);

  /// this a getter to access the parent widget
  final T1 widget;

  @override
  Widget build(BuildContext context);
}
