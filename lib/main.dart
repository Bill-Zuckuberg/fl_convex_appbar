import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

const _kPage = <String, IconData>{
  'home': Icons.home,
  'map': Icons.map,
  'add': Icons.add,
  'message': Icons.message,
  'people': Icons.people
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Convex Appbar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConvexAppbar(title: 'Convex Appbar'),
    );
  }
}

class ConvexAppbar extends StatefulWidget {
  const ConvexAppbar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ConvexAppbar> createState() => _ConvexAppbarState();
}

class _ConvexAppbarState extends State<ConvexAppbar> {
  TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        initialIndex: 2,
        child: Scaffold(
          body: Column(
            children: [
              _buildStyleSelector(),
              const Divider(),
              Expanded(
                  child: TabBarView(children: [
                for (var icon in _kPage.values) Icon(icon, size: 64)
              ]))
            ],
          ),
          bottomNavigationBar: ConvexAppBar.badge(const <int, dynamic>{
            3: '99+'
          },
              items: <TabItem>[
                for (var entry in _kPage.entries)
                  TabItem(icon: entry.value, title: entry.key)
              ],
              style: _tabStyle,
              onTap: null // (int i) => print('click index=$i'),
              ),
        ));
  }

  Widget _buildStyleSelector() {
    final dropdown = DropdownButton<TabStyle>(
      value: _tabStyle,
      onChanged: (newStyle) {
        if (newStyle != null) {
          setState(() {
            _tabStyle = newStyle;
          });
        }
      },
      items: [
        for (var style in TabStyle.values)
          DropdownMenuItem(
            child: Text(style.toString()),
            value: style,
          )
      ],
    );
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      title: const Text('Appbar style'),
      trailing: dropdown,
    );
  }
}
