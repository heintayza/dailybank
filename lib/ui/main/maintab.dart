import 'package:dailybank/models/tabicondata.dart';
import 'package:dailybank/ui/main/screens/accounts.dart';
import 'package:dailybank/ui/main/screens/history.dart';
import 'package:dailybank/ui/main/screens/home.dart';
import 'package:dailybank/ui/main/screens/profile.dart';
import 'package:dailybank/ui/utils/theme.dart';
import 'package:dailybank/ui/widgets/bottombarview.dart';
import 'package:flutter/material.dart';

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HomePage(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                tabBody,
                bottomBar(),
              ],
            );
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    //to get data
    return true;
  }

  Widget bottomBar() {
    List<Widget> screens = [
      HomePage(animationController: animationController),
      HistoryPage(animationController: animationController),
      AccountsPage(animationController: animationController),
      ProfilePage(animationController: animationController),
    ];
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            setState(() {
              tabBody = screens[index];
            });
          },
        ),
      ],
    );
  }
}
