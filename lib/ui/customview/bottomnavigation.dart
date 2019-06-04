

import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {

  BottomNavigation({
    this.children,
    this.items,
    this.fadeDuration
  });
  final List<Widget> children;
  final List<Widget> items;
  final Duration fadeDuration;

  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {

  int _currentIndex = 0;
  int _prevIndex = 1;
  List<Widget> _items;

  @override
  void initState() {
    super.initState();
    _items = List.generate(widget.items.length, (i) {
      return new InkWell(
          onTap: () => _changePage(i),
          child: widget.items[i]
      );
    });
  }

  void _changePage(int index) {
    if (index == _currentIndex) return;
    setState(() {
      this._prevIndex = _currentIndex;
      this._currentIndex = index;
    });
  }

  List<Widget> _buildTransitions() => List.generate(
      widget.children.length,
          (int i) => new AnimatedOpacity(
          opacity: _currentIndex == i ? 1.0 : 0.0,
          duration: widget.fadeDuration == null ? new Duration(milliseconds: 150) : widget.fadeDuration,
          child: widget.children[i]
      )
  ).toList();

  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
            children: _buildTransitions()
        ),
        bottomNavigationBar: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _items
        )
    );
  }
}
