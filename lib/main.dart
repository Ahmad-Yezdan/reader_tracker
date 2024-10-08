import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/pages/book_details_screen.dart';
import 'package:reader_tracker/pages/favorites_screen.dart';
import 'package:reader_tracker/pages/home_screen.dart';
import 'package:reader_tracker/pages/saved_screen.dart';
import 'package:reader_tracker/providers/home_provider.dart';
import 'package:reader_tracker/providers/major_provider.dart';
import 'package:reader_tracker/widgets/bottom_navigation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MajorProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reader Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          colorSchemeSeed: hexColortoMaterialColor(const Color(0xff9c000f)),
          useMaterial3: true,
          brightness: Brightness.light),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: hexColortoMaterialColor(const Color(0xff9c000f)),
          brightness: Brightness.dark),
      initialRoute: '/',
      routes: {
        'home': (context) => const HomeScreen(),
        'saved': (context) => const SavedScreen(),
        'favorites': (context) => const FavoritesScreen(),
        'details': (context) => const BookDetailsScreen(),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MajorProvider>(context);

    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reader"),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: provider.loadScreen(),
      bottomNavigationBar: BottomNavigation(theme: theme, provider: provider),
    );
  }
}

MaterialColor hexColortoMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
