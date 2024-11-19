import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:meal_app/shared/cubits/cubit/app_cubit.dart';
import 'package:meal_app/shared/styles/textStyles.dart';
import 'package:meal_app/shared/widgets/custom_grid.dart';

class MealsByCategoryScreen extends StatefulWidget {
  const MealsByCategoryScreen({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<MealsByCategoryScreen> createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  List<Meals> allMeals = []; // Store all meals
  List<Meals> filteredMeals = []; // Store filtered meals
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getMealByCategory(widget.categoryName);
    searchController.addListener(_filterMeals);
  }

  void _filterMeals() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredMeals = allMeals.where((meal) {
        return meal.strMeal?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterMeals);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetMealsByCategoryFailure) {
          if (state is GetSingleMealDetailesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: AwesomeSnackbarContent(
                    title: 'Error',
                    message: 'Handling Egyptian contente',
                    contentType: ContentType.failure),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        var meals = AppCubit.get(context).mealCategoryModel?.meals;

        if (state is GetMealsByCategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetMealsByCategoryFailure || meals == null) {
          return const Center(
            child: Text('NO DATA'),
          );
        }
        allMeals = meals;
        final displayMeals =
            filteredMeals.isNotEmpty ? filteredMeals : allMeals;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.categoryName,
              style: AppTextStyle.appBarStyle(),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              strokeAlign: BorderSide.strokeAlignOutside),
                          borderRadius: BorderRadius.circular(5)),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Meal',
                      hintStyle: AppTextStyle.subTitle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                      mainAxisExtent: 220.h,
                    ),
                    itemCount: displayMeals.length,
                    itemBuilder: (context, index) => CustomGrid(
                      imgUrl: displayMeals[index].strMealThumb ?? '',
                      mealName: displayMeals[index].strMeal ?? 'Koshari',
                      id: displayMeals[index].idMeal ?? '',
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
