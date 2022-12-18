import 'package:adm/core/constants.dart';
import 'package:adm/mainStances.dart';
import 'package:adm/modules/storie/storiesPage.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'modules/categories/categories_provider.dart';
import 'modules/categories/pages/category_main.dart';
import 'modules/products/productsPage.dart';
import 'modules/receipts/page/receiptListPage.dart';
import 'modules/users/page/usersPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      title: 'G20 admim',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/ListReceiptsPage':(context) => ListReceiptsPage()
      },
      home: const MyHomePage(title: 'easy_sidemenu Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Constants.instance.init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Scaffold(
                      backgroundColor: Color(0xff303D54),
                      appBar: AppBar(
                        backgroundColor: Color.fromARGB(255, 62, 79, 109),
                        leading: Icon(Icons.person),
                        actions: [],
                      ),
                      body: SideMenu(
                        controller: page,
                        style: SideMenuStyle(
                          openSideMenuWidth: 250,
                          displayMode: SideMenuDisplayMode.auto,
                          hoverColor: Color.fromARGB(255, 73, 89, 117),
                          selectedColor: Colors.lightBlue,
                          unselectedIconColor: Colors.white,
                          unselectedTitleTextStyle:
                              const TextStyle(color: Colors.white),
                          selectedTitleTextStyle:
                              const TextStyle(color: Colors.white),
                          selectedIconColor: Colors.white,
                        ),
                        title: Column(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 150,
                                maxWidth: 100,
                              ),
                            ),
                          ],
                        ),
                        footer: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'G20 admin',
                            style: TextStyle(fontSize: 15,color:Color.fromARGB(255, 73, 89, 117),),
                          ),
                        ),
                        items: [
                          SideMenuItem(
                            priority: 1,
                            title: 'Users',
                            onTap: () {
                              page.jumpToPage(1);
                            },
                            icon: const Icon(Icons.supervisor_account),
                          ),
                          SideMenuItem(
                            priority: 2,
                            title: 'Categorias',
                            onTap: () {
                              page.jumpToPage(2);
                            },
                            icon: const Icon(Icons.ad_units),
                          ),
                          SideMenuItem(
                            priority: 3,
                            title: 'Lojas',
                            onTap: () {
                              page.jumpToPage(3);
                            },
                            icon: const Icon(Icons.store),
                          ),
                          SideMenuItem(
                            priority: 4,
                            title: 'Produtos',
                            onTap: () {
                              page.jumpToPage(4);
                            },
                            icon: const Icon(Icons.production_quantity_limits),
                          ),
                          const SideMenuItem(
                            priority: 7,
                            title: 'Recibos',
                            icon: Icon(Icons.receipt),
                          ),
                          const SideMenuItem(
                            priority: 7,
                            title: 'Periodo',
                            icon: Icon(Icons.timelapse),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Scaffold(
                        appBar: AppBar(
                            backgroundColor: Colors.white,
                            leading: Icon(Icons.menu,color: Colors.grey,),
                            actions: [],
                          ),
                      body: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: page,
                        children: [
                          Container(),
                          Container(
                            color: Colors.white,
                            child: const Center(
                              child: UsersRegister()
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Center(child: CategoryProvider()),
                          ),
                          Container(
                            color: Colors.white,
                            child: const Center(child: StorieRegister()),
                          ),
                          const ProductsPage(),
                          //ReceiptComponent(),
                          Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'Only Icon',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
