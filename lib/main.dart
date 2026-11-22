import 'package:flutter/material.dart';

void main() => runApp(const ZuMatchApp());

const ivory = Color(0xFFFFF9F0);
const gold = Color(0xFFB98224);
const brown = Color(0xFF392317);

class ZuMatchApp extends StatelessWidget {
  const ZuMatchApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ZuMatch', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: ivory,
      colorScheme: ColorScheme.fromSeed(seedColor: gold, surface: ivory),
      appBarTheme: const AppBarTheme(backgroundColor: ivory, foregroundColor: brown),
      textTheme: const TextTheme(titleLarge: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold, color: brown))),
    home: const MainScreen(),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int selected = 0;
  final tabs = const ['Home', 'Explore', 'Interest', 'Chat', 'Profile'];
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Row(children: [const Icon(Icons.favorite, color: gold), const SizedBox(width: 8),
      Text('ZuMatch', style: Theme.of(context).textTheme.titleLarge)]),
      actions: [IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notifications coming soon'))), icon: const Icon(Icons.notifications_none))]),
    body: SafeArea(child: IndexedStack(index: selected, children: const [HomeTab(), ExploreTab(), PlaceholderTab(title: 'Interests', icon: Icons.favorite_border), PlaceholderTab(title: 'Messages', icon: Icons.chat_bubble_outline), PlaceholderTab(title: 'My Profile', icon: Icons.person_outline)])),
    bottomNavigationBar: NavigationBar(selectedIndex: selected, indicatorColor: const Color(0xFFF2DEB5), backgroundColor: ivory,
      onDestinationSelected: (i) => setState(() => selected = i), destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: gold), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Explore'),
        NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Interest'),
        NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile')])));
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Assalamu Alaikum', style: TextStyle(color: brown, fontSize: 15)),
    const Text('Find your life partner', style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold, fontSize: 25, color: brown)),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: [Color(0xFFF8E5C2), Color(0xFFD8A84D)])), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.mosque_outlined, size: 42, color: brown), SizedBox(height: 12), Text('Find Your Ideal Life Partner', style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold, fontSize: 24, color: brown)), Text('In a Halal & Respectful Way', style: TextStyle(color: brown))])),
    const SizedBox(height: 22), const Text('Suggested Matches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: brown)),
    const SizedBox(height: 12), const MatchCard(name: 'Ayesha', age: 24, city: 'Lucknow', job: 'Teacher'), const MatchCard(name: 'Zainab', age: 25, city: 'Delhi', job: 'Software Developer'), const MatchCard(name: 'Sana', age: 23, city: 'Aligarh', job: 'Student')
  ]);
}
class ExploreTab extends StatefulWidget { const ExploreTab({super.key}); @override State<ExploreTab> createState() => _ExploreTabState(); }
class _ExploreTabState extends State<ExploreTab> {
  String query = '';
  @override Widget build(BuildContext context) {
    final people = [('Ayesha',24,'Lucknow','Teacher'),('Zainab',25,'Delhi','Software Developer'),('Sana',23,'Aligarh','Student')];
    return ListView(padding: const EdgeInsets.all(18), children: [TextField(onChanged: (v) => setState(() => query = v), decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Search by name or city', border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)))), const SizedBox(height: 16), ...people.where((p) => p.$1.toLowerCase().contains(query.toLowerCase()) || p.$3.toLowerCase().contains(query.toLowerCase())).map((p) => MatchCard(name: p.$1, age: p.$2, city: p.$3, job: p.$4))]);
  }
}
class MatchCard extends StatelessWidget {
  final String name, city, job; final int age;
  const MatchCard({super.key, required this.name, required this.age, required this.city, required this.job});
  @override Widget build(BuildContext context) => Card(color: Colors.white, margin: const EdgeInsets.only(bottom: 12), elevation: 1, child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
    Container(width: 74, height: 84, decoration: BoxDecoration(color: const Color(0xFFF4E3C8), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.person_outline, color: gold, size: 38)),
    const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('$name, $age', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: brown)), Text('$job • $city'), const SizedBox(height: 6), const Row(children: [Icon(Icons.verified, color: Colors.green, size: 16), SizedBox(width: 4), Text('Demo profile', style: TextStyle(fontSize: 12))])])),
    IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Interest requests coming soon'))), icon: const Icon(Icons.favorite_border, color: gold))
  ])));
}
class PlaceholderTab extends StatelessWidget {
  final String title; final IconData icon;
  const PlaceholderTab({super.key, required this.title, required this.icon});
  @override Widget build(BuildContext context) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 60, color: gold), const SizedBox(height: 12), Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: brown)), const SizedBox(height: 8), const Text('Coming in the next development phase')])));
}
