import 'package:colomer_dental/src/connect/connection.dart';
import 'package:colomer_dental/src/models/clinicasModel.dart';
import 'package:colomer_dental/src/pages/addEvent.dart';
import 'package:colomer_dental/src/pages/citasPage.dart';
import 'package:colomer_dental/src/pages/clinicasPage.dart';
import 'package:colomer_dental/src/pages/datosUsuarioPage.dart';
import 'package:colomer_dental/src/pages/homePage.dart';
import 'package:colomer_dental/src/pages/login.dart';
import 'package:colomer_dental/src/pages/userPage.dart';
import 'package:colomer_dental/src/providers/providerPage.dart';
import 'package:colomer_dental/src/sharedPreferences/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final pref = PreferenciasUsuario();
List<Clinicas> clinicas = [];
void main() async {
  final _clinicasProvider = ClinicasProvider();
  WidgetsFlutterBinding.ensureInitialized();
  await pref.initPrefs();
  clinicas = await _clinicasProvider.getClinicas();
  print(clinicas);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (context) => ProviderPage(),
      child: MaterialApp(
        //supportedLocales: [Locale('es', 'ES')],
        locale: Locale('es', 'ES'),
        debugShowCheckedModeBanner: false,
        title: 'Colomer dental',
        initialRoute: pref.pagePral,
        routes: {
          '/news': (BuildContext context) => HomePage(),
          '/bottom': (BuildContext context) => ButtomAppBarNab(),
          '/login': (BuildContext cntext) => LoginPage(),
          '/add': (BuildContext cntext) => AddEventPage(),
          '/citas': (BuildContext cntext) => CitasPage(),
          '/clinicas': (BuildContext cntext) => ClinicasPage(),
          '/datos': (BuildContext cntext) => DatosUsuarioPage(),
        },
      ),
    );
  }
}

class ButtomAppBarNab extends StatefulWidget {
  ButtomAppBarNab({Key key}) : super(key: key);

  @override
  _ButtomAppBarNabState createState() => _ButtomAppBarNabState();
}

class _ButtomAppBarNabState extends State<ButtomAppBarNab> {
  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<ProviderPage>(context);
    List<Widget> paginas = [
      HomePage(),
      CitasPage(),
      ClinicasPage(),
      UserPage()
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: pageProvider.page,
            onTap: (value) {
              pageProvider.date = null;
              pageProvider.page = value;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.new_releases,
                  ),
                  label: "Noticias"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: ("Citas")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.store_mall_directory), label: ("Clínicas")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: ("Usuario"))
            ]),
        body: paginas[pageProvider.page]);
  }
}
