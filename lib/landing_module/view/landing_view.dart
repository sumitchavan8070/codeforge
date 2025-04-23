import 'package:codeforge/landing_module/view/category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Provider to manage the current tab index
final tabIndexProvider = StateNotifierProvider<TabIndexNotifier, int>((ref) {
  return TabIndexNotifier();
});

class TabIndexNotifier extends StateNotifier<int> {
  TabIndexNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.split(" ").first),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Text(title, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(title: 'Home Screen');
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(title: 'Favorites Screen');
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(title: 'Cart Screen');
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(title: 'Profile Screen');
  }
}

class LandingView extends ConsumerStatefulWidget {
  const LandingView({super.key});

  @override
  ConsumerState<LandingView> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<LandingView> {
  final PageController _pageController = PageController(initialPage: 2);

  final List<Widget> _pages = const [
    HomeScreen(),
    FavoritesScreen(),
    CategoryView(),
    CartScreen(),
    ProfileScreen(),
  ];

  final List<String> navigationIconsList = [
    "assets/vectors/home.svg",
    "assets/vectors/heart.svg",
    "assets/vectors/heart.svg", // Assuming placeholder for category icon
    "assets/vectors/cart.svg",
    "assets/vectors/profile.svg",
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(tabIndexProvider);

    void navigation(int index) {
      ref.read(tabIndexProvider.notifier).setIndex(index);
      _pageController.jumpToPage(index);
    }

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          ref.read(tabIndexProvider.notifier).setIndex(index);
        },
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        height: 60,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(navigationIconsList.length, (index) {
              final icon = navigationIconsList[index];
              final isActive = currentIndex == index;

              // Special FAB-style middle button
              if (index == 2) {
                return GestureDetector(
                  onTap: () => navigation(index),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 40,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF066AC9),
                    ),
                    child: SvgPicture.asset(
                      "assets/vectors/cart.svg",
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => navigation(index),
                child: SvgPicture.asset(
                  icon,
                  colorFilter:
                      isActive ? const ColorFilter.mode(Color(0xFF066AC9), BlendMode.srcIn) : null,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
