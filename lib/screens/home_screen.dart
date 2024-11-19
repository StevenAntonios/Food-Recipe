import 'package:meal_app/index.dart';
export 'package:meal_app/models/area_mode.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  
  List<Meals> _filterMeals(List<Meals> meaals) {
    if (searchQuery.isEmpty) {
      return meaals;
    }
    return meaals.where((meal) {
      return meal.strMeal?.toLowerCase().contains(searchQuery) ?? false;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Meal App',
          style: AppTextStyle.appBarStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                )),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Main dishes in Egypt',
                      style: AppTextStyle.titleStyle(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocConsumer<AppCubit, AppState>(
                      listener: (context, state) {
                        if (state is FilterMealsByEgyptFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Handling Egyptian contente',
                                  contentType: ContentType.failure),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        var meals = AppCubit.get(context).egyptModel?.meals;
                        if (state is FilterMealsByEgyptLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FilterMealsByEgyptFailure ||
                            meals == null ||
                            meals.isEmpty) {
                          return const Center(
                            child: Text('Failed'),
                          );
                        } else {
                          var filterMeals = _filterMeals(meals);

                          return Skeletonizer(
                            enabled: false,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.w,
                                mainAxisSpacing: 20.h,
                                mainAxisExtent: 220.h,
                              ),
                              itemCount: filterMeals.length,
                              itemBuilder: (context, index) => CustomGrid(
                                imgUrl:filterMeals[index].strMealThumb ??
                                    Constants.cachedImg,
                                mealName:filterMeals[index].strMeal ?? 'Koshari',
                                id: filterMeals[index].idMeal ?? '4512',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Main dishes in America',
                      style: AppTextStyle.titleStyle(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocConsumer<AppCubit, AppState>(
                      listener: (context, state) {
                        if (state is FilterMealsByAmericaFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Handling American contente',
                                  contentType: ContentType.failure),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        var meals = AppCubit.get(context).americaModel?.meals;
                       
                        if (state is FilterMealsByAmericaLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FilterMealsByAmericaFailure ||
                            meals == null ||
                            meals.isEmpty) {
                          return const Center(
                            child: Text('Failed'),
                          );
                        }
                         var filterMeals = _filterMeals(meals);
                        return Skeletonizer(
                          
                          enabled: false,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.w,
                              mainAxisSpacing: 20.h,
                              mainAxisExtent: 220.h,
                            ),
                            itemCount: filterMeals.length,
                            itemBuilder: (context, index) => CustomGrid(
                              imgUrl:filterMeals[index].strMealThumb ??
                                  Constants.cachedImg,
                              mealName: filterMeals[index].strMeal ?? 'Koshari',
                              id: filterMeals[index].idMeal!,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
