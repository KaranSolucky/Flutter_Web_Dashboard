import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/test1/test1.dart';
import 'package:admin/screens/test2/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget selectedWidget = DashboardScreen();
  bool isSelected = false;
  int selectedIndex = 0;

  void showChildWidget(int index) {
    switch (index) {
      case 0:
        selectedWidget = DashboardScreen();

        break;
      case 1:
        selectedWidget = Test1();

        break;
      case 2:
        selectedWidget = Test2();

        break;
      case 3:
        selectedWidget = DashboardScreen();

        break;
      // case 4:
      //   selectedWidget = const AddressProof();

      //   break;
      // case 5:
      //   selectedWidget = AddressProof();

      //   break;
      // case 6:
      //   selectedWidget = AddressProof();

      //   break;
      // case 7:
      //   selectedWidget = AddressProof();

      //   break;
      default:
    }
  }

  List<String> drawerItems = [
    "Dashboard",
    "Transaction",
    "Task",
    "Documents",
    "Store",
    "Notification",
    "Profile",
    "Settings",
  ];
  List<String> svgIcons = [
    "assets/icons/menu_dashbord.svg",
    "assets/icons/menu_tran.svg",
    "assets/icons/menu_task.svg",
    "assets/icons/menu_doc.svg",
    "assets/icons/menu_store.svg",
    "assets/icons/menu_notification.svg",
    "assets/icons/menu_profile.svg",
    "assets/icons/menu_setting.svg",
  ];
  List<Icon> icons = [
    Icon(Icons.home),
    Icon(Icons.account_circle),
    Icon(Icons.add_home_work_sharp),
    Icon(Icons.lock)
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: Drawer(
                      backgroundColor: primaryColor,
                      child: Column(
                        children: [
                          DrawerHeader(
                            child: Image.asset("assets/images/logo.png"),
                          ),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: drawerItems.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => setState(() => {
                                          isSelected = true,
                                          selectedIndex = index,
                                          showChildWidget(selectedIndex)
                                        }),
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? secondaryColor
                                            : primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          // topRight: Radius.,
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      // height: 70,
                                      child: Row(children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SvgPicture.asset(
                                          svgIcons[index],
                                          color: selectedIndex == index
                                              ? Colors.white
                                              : Colors.white,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          drawerItems[index],
                                          style: TextStyle(
                                              color: selectedIndex == index
                                                  ? Colors.white
                                                  : Colors.white),
                                        )
                                      ]),
                                    ),
                                  );

                                  // ListTile(
                                  //   tileColor: selectedIndex == index
                                  //       ? secondaryColor
                                  //       : primaryColor,
                                  //   onTap: () => setState(() => {
                                  //         isSelected = true,
                                  //         selectedIndex = index,
                                  //         showChildWidget(selectedIndex)
                                  //       }),
                                  //   horizontalTitleGap: 0.0,
                                  //   leading: SvgPicture.asset(
                                  //     svgIcons[index],
                                  //     color: selectedIndex == index
                                  //         ? secondaryColor
                                  //         : Colors.white,
                                  //     height: 16,
                                  //   ),
                                  //   title: Text(
                                  //     drawerItems[index],
                                  //     style: TextStyle(
                                  //         color: selectedIndex == index
                                  //             ? Colors.white
                                  //             : Colors.white),
                                  //   ),
                                  // );
                                }),
                          ),
                        ],
                      ))),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: selectedWidget,
            ),
          ],
        ),
      ),
    );
  }
}
