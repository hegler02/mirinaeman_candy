import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/menu_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 세로 방향 고정
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const HalloweenCandyCatchApp());
}

class HalloweenCandyCatchApp extends StatelessWidget {
  const HalloweenCandyCatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '할로윈 캔디 캐치',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF1a0033),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
}
