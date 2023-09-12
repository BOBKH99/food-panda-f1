import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    required GlobalKey<ScaffoldState> key,
  }) : _key = key;

  final GlobalKey<ScaffoldState> _key;

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const ListTile(
        title: Text('2 St 762', style: TextStyle(
            fontWeight: FontWeight.bold
        )),
        subtitle: Text('Phnom Penh'),
      ),
      leading: IconButton(
          onPressed: () {
            // Scaffold.of(context).openDrawer();
            _key.currentState!.openDrawer();
          },
          icon: const Icon(Icons.line_weight)),
      leadingWidth: 20,
      actions: const [
        Icon(Icons.favorite),
        SizedBox(width: 10,),
        Icon(Icons.shopping_basket),
        SizedBox(width: 10,),
      ],
    );
  }


}
