import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea_forge/builder/drag_drop_engine.dart';
import 'package:idea_forge/marketplace/marketplace_provider.dart';
import 'screens/app_builder_visual.dart';
import 'screens/marketplace_ideias.dart';
import 'screens/meu_portfolio.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DragDropEngine()),
        ChangeNotifierProvider(create: (_) => MarketplaceProvider()),
      ],
      child: const IdeaForgeApp(),
    ),
  );
}

class IdeaForgeApp extends StatelessWidget {
  const IdeaForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IdeaForge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21), // Profundo escuro
        primaryColor: const Color(0xFF00E676), // Verde Dinheiro
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676),
          secondary: Color(0xFF6C63FF), // Roxo Tech
          surface: Color(0xFF1D1E33),
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.outfitTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white, displayColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AppBuilderVisual(),
    const MarketplaceIdeias(),
    const MeuPortfolio(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF1D1E33),
        indicatorColor: Theme.of(context).primaryColor.withOpacity(0.2),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.build_rounded),
            selectedIcon: Icon(Icons.build, color: Color(0xFF00E676)),
            label: 'Criar App',
          ),
          NavigationDestination(
            icon: Icon(Icons.rocket_launch_rounded),
            selectedIcon: Icon(Icons.rocket_launch, color: Color(0xFF6C63FF)),
            label: 'Marketplace',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_rounded),
            selectedIcon: Icon(Icons.account_circle, color: Colors.white),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
