import 'package:flutter/material.dart';

import 'package:cyircle_app/models/category.dart';
import 'package:cyircle_app/providers/my_category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dummy Data
final List<Category> dummyCategories = [
  Category(
    name: 'Books',
    description: 'All kinds of books',
    colors: [255, 33, 150, 243], // Blue
    userId: 'user1',
  ),
  Category(
    name: 'Electronics',
    description: 'Gadgets and devices',
    colors: [255, 76, 175, 80], // Green
    userId: 'user1',
  ),
  Category(
    name: 'Furniture',
    description: 'Home and office furniture',
    colors: [255, 156, 39, 176], // Purple
    userId: 'user1',
  ),
];

class CategoriesTab extends ConsumerStatefulWidget {
  const CategoriesTab({super.key});
  @override
  ConsumerState<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends ConsumerState<CategoriesTab> {
  late Future<void> _loadMyCategories;

  @override
  void initState() {
    super.initState();

    _loadMyCategories = ref.read(myCategoryProvider.notifier).loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final myCategories = ref.watch(myCategoryProvider);

    return FutureBuilder(
      future: _loadMyCategories,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3 / 2, // Width / Height ratio
            ),
            itemCount: myCategories.length,
            itemBuilder: (context, index) {
              final category = myCategories[index];
              return _CategoryCard(category: category);
            },
          ),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;

  const _CategoryCard({required this.category});

  Color get baseColor => Color.fromARGB(
    category.colors[0],
    category.colors[1],
    category.colors[2],
    category.colors[3],
  );

  Color lightenColor(Color color, [double amount = 0.3]) {
    final hsl = HSLColor.fromColor(color);
    final lighterHsl = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return lighterHsl.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final lightColor = lightenColor(baseColor, 0.2);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [baseColor, lightColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Handle tap
        },
        splashColor: lightColor,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  category.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: Colors.white70),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
