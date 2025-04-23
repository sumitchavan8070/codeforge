import 'package:cached_network_image/cached_network_image.dart';
import 'package:codeforge/landing_module/model/category_model.dart';
import 'package:codeforge/landing_module/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryView extends ConsumerWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoryProvider);
    print('Building CategoryScreen');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        automaticallyImplyLeading: true,
      ),
      body: categoriesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('An error occurred'),
              ElevatedButton(
                onPressed: () => ref.refresh(categoryProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text('No categories available'));
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 18,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(category: category);
                  },
                ),
              ),
              const SizedBox(height: 60), // Add this SizedBox at the bottom
            ],
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: category.iconUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) {
              print(" url : $url, error $error");
              return const Icon(Icons.error, size: 64, color: Colors.red);
            },
          ),
          const SizedBox(height: 8.0),
          Text(
            category.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
