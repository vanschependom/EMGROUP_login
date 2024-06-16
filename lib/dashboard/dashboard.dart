import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ColorScheme _colorScheme = Theme.of(context).colorScheme;

    void showPopupWindow() {
      // pas dit aan naar een pagina ipv een popup
      // als er veel content op het 'tikken met' scherm moet komen
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopupTikking();
        },
      );
    }

    List<Widget> floatingActionButtons = [
      LongPressItem(
        item: FloatingActionButton(
          key: ValueKey<int>(1),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tikking gemaakt!'),
                behavior: SnackBarBehavior.floating,
                elevation: 0,
              ),
            );
          },
          child: const Icon(Icons.more_time),
          shape: const CircleBorder(),
        ),
        onLongPress: () {
          //show popup window
          showPopupWindow();
        },
      ), // Execute the onLongPress callback
      Container(
        key: ValueKey<int>(2),
      ),
      FloatingActionButton(
        key: ValueKey<int>(3),
        onPressed: () {
          showModalBottomSheet(
            enableDrag: true,
            showDragHandle: true,
            useSafeArea: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: const Text(
                        "Welke aanvraag wil je indienen?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.card_travel_rounded),
                      title: const Text('Code'),
                      onTap: () {
                        Navigator.of(context).pop();
                        // open vakantie aanvraag form
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.euro_rounded),
                      title: const Text('Vergoeding'),
                      onTap: () {
                        Navigator.of(context).pop();
                        // open verlof aanvraag form
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer_outlined),
                      title: const Text('Tikking'),
                      onTap: () {
                        Navigator.of(context).pop();
                        // open ziekte aanvraag form
                      },
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 50),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Sluiten"),
                    ),
                    Padding(padding: const EdgeInsets.only(bottom: 20)),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
        tooltip: "Aanvraag indienen",
        shape: const CircleBorder(),
      ),
      Container(
        key: ValueKey<int>(4),
      ),
    ];

    Widget fab = floatingActionButtons[_currentIndex];

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: Text(
                  'Meer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                title: Text('Instellingen'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Uitloggen'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            HomePage(),
            TeamverlofPage(),
            AanvragenPage(),
          ],
          physics: ClampingScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
              fab = floatingActionButtons[index];
            });
          },
        ),
      ),
      floatingActionButton: Container(
        width: 56.0,
        height: 56.0,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final Animation<double> curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
            );
            return ScaleTransition(
              child: child,
              scale: curvedAnimation,
            );
          },
          child: floatingActionButtons[_currentIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        unselectedItemColor: _colorScheme.onSurface,
        selectedItemColor: _colorScheme.primary,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Teamverlof',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Aanvragen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            activeIcon: Icon(Icons.menu),
            label: 'Meer',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != 3) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
            setState(() {
              _currentIndex = index;
              fab = floatingActionButtons[index];
            });
          } else {
            _scaffoldKey.currentState?.openEndDrawer();
          }
        },
      ),
    );
  }
}

class PopupTikking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tikken met ...'),
      icon: Icon(
        Icons.timer_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 100),
      content: Center(
        child: Text("Hier komt de content"),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Dashboard'),
    );
  }
}

class TeamverlofPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Teamverlof'),
    );
  }
}

class AanvragenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Aanvragen'),
    );
  }
}

class ProfielPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profiel'),
    );
  }
}

class LongPressItem extends StatelessWidget {
  final Widget item;
  final VoidCallback onLongPress;

  LongPressItem({required this.item, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: item,
      onLongPress: onLongPress, // Execute the onLongPress callback
    );
  }
}
