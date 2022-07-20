import 'package:chat_app/screens/home/calls.dart';
import 'package:chat_app/screens/home/contacts.dart';
import 'package:chat_app/screens/home/messages.dart';
import 'package:chat_app/screens/home/notifications.dart';
import 'package:chat_app/utils/theme.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:chat_app/widgets/glowing_action_button.dart';
import 'package:chat_app/widgets/icon_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    setStatus(true);
  }

  // set users status
  void setStatus(bool status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'status': status,
      'lastOnline': DateTime.now().microsecondsSinceEpoch,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) setStatus(true);
    else setStatus(false);
    super.didChangeAppLifecycleState(state);
  }

  final ValueNotifier<int> _index = ValueNotifier(0);
  final ValueNotifier<String> _title = ValueNotifier('Messages');

  final _pages = const [
    MessagesScreen(),
    NotificationsScreen(),
    CallsScreen(),
    ContactsScreen()
  ];

  final _titles = const ['Messages', 'Notifications', 'Calls', 'Contacts'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.center,
          child: IconBackground(onTap: () {  }, iconData: Icons.search),
        ),
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: _title,
          builder: (BuildContext context, String val, _) {
            return Text(val, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
              child: Avatar.small(url: 'https://m.economictimes.com/thumb/msid-85509633,width-1200,height-900,resizemode-4,imgsize-55892/angelina-jolie-posted-the-entire-letter-of-the-young-girl-along-with-a-photo-of-seven-afghan-women-standing-with-their-backs-to-the-camera-.jpg'))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _index,
        builder: (BuildContext context, int val, _) => _pages[val],
      ),
      bottomNavigationBar: _BottomNavigationBar(onItemChanged: (int val) {
        _title.value = _titles[val];
        _index.value = val;
      }),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemChanged}) : super(key: key);

  final ValueChanged<int> onItemChanged;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var _selected = 0;
  void handleItemSelected(int i) {
    setState(() => _selected = i);
    widget.onItemChanged(i);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(onTap: handleItemSelected, index: 0, isSelected: _selected == 0, label: 'Messages', iconData: Icons.message,),
              _NavigationBarItem(onTap: handleItemSelected, index: 1, isSelected: _selected == 1, label: 'Notifications', iconData: Icons.notifications_none,),
              GlowingActionButton(color: AppColors.secondary, iconData: Icons.add, onPressed: () {}),
              _NavigationBarItem(onTap: handleItemSelected, index: 2, isSelected: _selected == 2, label: 'Calls', iconData: Icons.call),
              _NavigationBarItem(onTap: handleItemSelected, index: 3, isSelected: _selected == 3, label: 'Contacts', iconData: Icons.people,)
            ],
          ),
        )
      ),
    );
  }
}


class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({Key? key, required this.onTap, this.isSelected = false, required this.index, required this.label, required this.iconData}) : super(key: key);

  final bool isSelected;
  final ValueChanged<int> onTap;
  final int index;
  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 20, color: isSelected ? AppColors.secondary : null),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isSelected ? AppColors.secondary : null))
          ],
        ),
      ),
    );
  }
}

