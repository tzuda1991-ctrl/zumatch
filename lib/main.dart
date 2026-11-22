import 'extra_screens.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ZuMatchApp());

const ivory = Color(0xFFFFF8EF);
const gold = Color(0xFFB78224);
const dark = Color(0xFF392315);
const cream = Color(0xFFF6E6CE);

class ZuMatchApp extends StatelessWidget {
  const ZuMatchApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ZuMatch', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: ivory,
      colorScheme: ColorScheme.fromSeed(seedColor: gold, surface: ivory),
      appBarTheme: const AppBarTheme(backgroundColor: ivory, foregroundColor: dark, centerTitle: true),
      textTheme: const TextTheme(titleLarge: TextStyle(fontFamily: 'serif', color: dark, fontWeight: FontWeight.bold))),
    home: const WelcomeScreen(),
  );
}

class GoldButton extends StatelessWidget {
  final String text; final VoidCallback onPressed;
  const GoldButton({super.key, required this.text, required this.onPressed});
  @override Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 48,
    child: DecoratedBox(decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFE2B957), Color(0xFF9E6915)]), borderRadius: BorderRadius.circular(14)),
      child: TextButton(onPressed: onPressed, child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))));
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(body: SafeArea(child: Container(
    width: double.infinity, padding: const EdgeInsets.all(28),
    decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8E7C7), ivory, Color(0xFFF0D6A8)])),
    child: Column(children: [
      const Spacer(), const Icon(Icons.mosque, size: 96, color: gold), const SizedBox(height: 20),
      const Icon(Icons.favorite, color: gold, size: 52),
      const Text('ZuMatch', style: TextStyle(fontFamily: 'serif', fontSize: 52, fontWeight: FontWeight.bold, color: dark)),
      const Text('MUSLIM MATRIMONY', style: TextStyle(letterSpacing: 3, color: dark)),
      const Spacer(), const Text('Find Your Perfect Nikah Partner', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'serif', fontSize: 29, color: dark)),
      const SizedBox(height: 12), const Text('A Halal, Safe & Trusted Platform for Your Nikah', textAlign: TextAlign.center, style: TextStyle(color: dark)),
      const SizedBox(height: 32), GoldButton(text: 'Get Started  →', onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const IntroScreen()))),
      const SizedBox(height: 20)
    ]),
  )));
}

class Match {
  final String name, city, profession, education, photo;
  final int age;
  const Match(this.name, this.age, this.city, this.profession, this.education, this.photo);
}
const matches = [
  Match('Ayesha', 24, 'Lucknow, UP', 'Teacher', 'B.Ed', 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=700'),
  Match('Zainab', 25, 'Delhi', 'Software Developer', 'B.Tech', 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=700'),
  Match('Sana', 23, 'Aligarh, UP', 'Student', 'B.A', 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=700'),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int selected = 0;
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.favorite, color: gold), SizedBox(width: 8),
      Text('ZuMatch', style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold, fontSize: 27, color: dark))
    ]), actions: [IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumScreen())), icon: const Icon(Icons.workspace_premium_outlined)), IconButton(onPressed: () => showNotice(context), icon: const Icon(Icons.notifications_none))]),
    body: SafeArea(child: IndexedStack(index: selected, children: const [
      HomeTab(), ExploreTab(), InterestScreen(),
      MessagesScreen(), MyProfileScreen()
    ])),
    bottomNavigationBar: NavigationBar(backgroundColor: ivory, indicatorColor: cream, selectedIndex: selected,
      onDestinationSelected: (i) => setState(() => selected = i), destinations: const [
      NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: gold), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.search), label: 'Explore'),
      NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Interest'),
      NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
      NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
    ]),
  );
}
void showNotice(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This feature will be connected to the backend in the next phase.')));

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(17), children: [
    const Text('Assalamu Alaikum,', style: TextStyle(color: dark, fontSize: 15)),
    const Text('Welcome to ZuMatch 👋', style: TextStyle(fontFamily: 'serif', fontSize: 25, fontWeight: FontWeight.bold, color: dark)),
    const SizedBox(height: 16),
    Container(height: 155, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(colors: [Color(0xFFF8E5C9), Color(0xFFE7C082)]), border: Border.all(color: const Color(0xFFE4BE7C))),
      child: const Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Find Your Ideal\nLife Partner', style: TextStyle(fontFamily: 'serif', color: dark, fontWeight: FontWeight.bold, fontSize: 24)),
          SizedBox(height: 8), Text('In a Halal & Respectful Way', style: TextStyle(color: dark, fontSize: 12))
        ])), Icon(Icons.mosque, color: gold, size: 90)
      ])),
    const SizedBox(height: 18),
    const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      QuickAction(Icons.search, 'Explore'), QuickAction(Icons.favorite_border, 'Interest'),
      QuickAction(Icons.chat_bubble_outline, 'Messages'), QuickAction(Icons.visibility_outlined, 'Visitors'),
      QuickAction(Icons.workspace_premium_outlined, 'Premium')
    ]),
    const SizedBox(height: 22),
    const Text('Suggested Matches', style: TextStyle(fontFamily: 'serif', fontSize: 23, fontWeight: FontWeight.bold, color: dark)),
    const SizedBox(height: 12),
    GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: matches.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: .68),
      itemBuilder: (context, index) => MatchTile(match: matches[index])),
    const SizedBox(height: 12)
  ]);
}
class QuickAction extends StatelessWidget {
  final IconData icon; final String label;
  const QuickAction(this.icon, this.label, {super.key});
  @override Widget build(BuildContext context) => Column(children: [
    Container(width: 52, height: 52, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: cream)),
      child: Icon(icon, color: gold, size: 25)), const SizedBox(height: 5),
    Text(label, style: const TextStyle(fontSize: 10, color: dark))
  ]);
}
class MatchPhoto extends StatelessWidget {
  final Match match;
  const MatchPhoto({super.key, required this.match});
  @override Widget build(BuildContext context) => Image.network(match.photo, fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => const ColoredBox(color: cream, child: Center(child: Icon(Icons.person, size: 65, color: gold))));
}
class MatchTile extends StatelessWidget {
  final Match match;
  const MatchTile({super.key, required this.match});
  @override Widget build(BuildContext context) => InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(match: match))),
    child: Container(clipBehavior: Clip.antiAlias, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFE8D3AE)), boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 9, offset: Offset(0, 3))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Stack(fit: StackFit.expand, children: [
          MatchPhoto(match: match),
          const Positioned(left: 7, bottom: 7, child: DecoratedBox(decoration: BoxDecoration(color: ivory, borderRadius: BorderRadius.all(Radius.circular(14))), child: Padding(padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.verified, color: Colors.green, size: 13), SizedBox(width: 3), Text('Demo', style: TextStyle(fontSize: 10))]))))
        ])),
        Padding(padding: const EdgeInsets.all(9), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${match.name}, ${match.age}', style: const TextStyle(fontFamily: 'serif', fontSize: 18, fontWeight: FontWeight.bold, color: dark)),
          Text('${match.profession} • ${match.city}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 7),
          Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 7), decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(10)), child: const Text('View Profile  →', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)))
        ]))
      ])));
}
class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});
  @override State<ExploreTab> createState() => _ExploreTabState();
}
class _ExploreTabState extends State<ExploreTab> {
  String query = '';
  @override Widget build(BuildContext context) {
    final filtered = matches.where((m) => m.name.toLowerCase().contains(query.toLowerCase()) || m.city.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView(padding: const EdgeInsets.all(18), children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Explore Matches', style: TextStyle(fontFamily: 'serif', fontSize: 26, color: dark, fontWeight: FontWeight.bold)), IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FiltersScreen())), icon: const Icon(Icons.tune, color: gold))]),
      const SizedBox(height: 14),
      TextField(onChanged: (v) => setState(() => query = v), decoration: InputDecoration(prefixIcon: const Icon(Icons.search, color: gold), hintText: 'Search name or city', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
      const SizedBox(height: 18),
      GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: filtered.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: .68),
        itemBuilder: (_, i) => MatchTile(match: filtered[i]))
    ]);
  }
}
class ProfileScreen extends StatelessWidget {
  final Match match;
  const ProfileScreen({super.key, required this.match});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile Details', style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold))),
    body: SafeArea(child: Column(children: [
      Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
        SizedBox(height: 280, child: ClipRRect(borderRadius: BorderRadius.circular(20), child: MatchPhoto(match: match))),
        const SizedBox(height: 15),
        Text('${match.name}, ${match.age}', style: const TextStyle(fontFamily: 'serif', fontSize: 30, fontWeight: FontWeight.bold, color: dark)),
        const SizedBox(height: 8),
        Text('${match.profession}  •  ${match.city}', style: const TextStyle(fontSize: 16, color: dark)),
        const SizedBox(height: 20),
        const Text('About Me', style: TextStyle(fontFamily: 'serif', fontSize: 22, fontWeight: FontWeight.bold, color: dark)),
        const SizedBox(height: 8),
        const Text('Demo profile for UI preview. Real profile information will be shown after backend integration.'),
        const SizedBox(height: 22),
        const Text('Personal Details', style: TextStyle(fontFamily: 'serif', fontSize: 22, fontWeight: FontWeight.bold, color: dark)),
        const Divider(), detail('Education', match.education), detail('Profession', match.profession), detail('Location', match.city)
      ])),
      Padding(padding: const EdgeInsets.all(16), child: GoldButton(text: '♡  Send Interest', onPressed: () => showNotice(context)))
    ])));
}
Widget detail(String title, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(color: dark)), Flexible(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.bold, color: dark)))]));
class EmptyTab extends StatelessWidget {
  final String title; final IconData icon;
  const EmptyTab(this.title, this.icon, {super.key});
  @override Widget build(BuildContext context) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, color: gold, size: 70), const SizedBox(height: 15),
    Text(title, style: const TextStyle(fontFamily: 'serif', fontSize: 25, fontWeight: FontWeight.bold, color: dark)),
    const SizedBox(height: 8), const Text('Available after backend integration', style: TextStyle(color: dark))
  ]));
}
