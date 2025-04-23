import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codeforge/landing_module/model/category_model.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, AsyncValue<List<CategoryModel>>>(
    (ref) => CategoryNotifier());

class CategoryNotifier extends StateNotifier<AsyncValue<List<CategoryModel>>> {
  CategoryNotifier() : super(const AsyncValue.loading()) {
    _loadCategories();
  }

  void _loadCategories() {
    try {
      final categoryList = _mockCategoryJson.entries.map((entry) {
        final data = entry.value as Map<String, dynamic>;
        return CategoryModel.fromJson(data);
      }).toList();

      state = AsyncValue.data(categoryList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  final Map<String, dynamic> _mockCategoryJson = {
    "Nature": {
      "id": "1",
      "name": "Nature",
      "iconUrl":
          "https://img.freepik.com/free-photo/beautiful-strawberry-garden-sunrise-doi-ang-khang-chiang-mai-thailand_335224-762.jpg?ga=GA1.1.878545139.1740049367&semt=ais_hybrid&w=740"
    },
    "Animals": {
      "id": "2",
      "name": "Animals",
      "iconUrl":
          "https://i.natgeofe.com/k/c022030e-f1aa-4ab3-ad56-fdcdd4a1d08b/125-animals-tiger.jpg?wp=1&w=1084.125&h=609"
    },
    "Technology": {
      "id": "3",
      "name": "Technology",
      "iconUrl":
          "https://imageio.forbes.com/specials-images/imageserve/6200b0dddcf32d3be937fa84/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds"
    },
    "Architecture": {
      "id": "4",
      "name": "Architecture",
      "iconUrl":
          "https://www.arch2o.com/wp-content/uploads/2022/10/Arch2O-10-of-the-most-eye-opening-iconic-buildings-of-modern-architecture.jpg"
    },
    "People": {
      "id": "5",
      "name": "People",
      "iconUrl":
          "https://previews.123rf.com/images/gdolgikh/gdolgikh1504/gdolgikh150400087/38738606-group-of-happy-young-people-isolated-on-white-background.jpg"
    },
    "Food": {
      "id": "6",
      "name": "Food",
      "iconUrl":
          "https://media.istockphoto.com/id/1829241109/photo/enjoying-a-brunch-together.jpg?s=612x612&w=0&k=20&c=9awLLRMBLeiYsrXrkgzkoscVU_3RoVwl_HA-OT-srjQ="
    },
    "Travel": {
      "id": "7",
      "name": "Travel",
      "iconUrl":
          "https://media.istockphoto.com/id/904172104/photo/weve-made-it-all-this-way-i-am-proud.jpg?s=612x612&w=0&k=20&c=MewnsAhbeGRcMBN9_ZKhThmqPK6c8nCT8XYk5ZM_hdg="
    },
    "Sports": {
      "id": "8",
      "name": "Sports",
      "iconUrl":
          "https://media.istockphoto.com/id/1188462138/photo/variety-of-sport-accessories-on-wooden-surface.jpg?s=612x612&w=0&k=20&c=y2l7DYNkxbVteZy-Kx_adCzm-soTRbiEypje4j8ENe0="
    },
    "Art & Design": {
      "id": "9",
      "name": "Art & Design",
      "iconUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROQ04coUpc7e9bQfLukS9RNgSxoF8NnpyTqQ&s"
    },
    "Space": {
      "id": "10",
      "name": "Space",
      "iconUrl":
          "https://d10lvax23vl53t.cloudfront.net/images/Article_Images/ImageForArticle_2358_16363728816453386.jpg"
    },
  };
}
