import 'package:meal_app/index.dart';
import 'package:meal_app/models/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Categories> allCategories = []; // Store all categories
  List<Categories> filteredCategories = []; // Store filtered categories
  final TextEditingController searchController = TextEditingController();

  void initState() {
    super.initState();
    AppCubit.get(context).getAllCategories();
    searchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCategories = allCategories.where((category) {
        return category.strCategory?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterCategories);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetAllCategoriesFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: AwesomeSnackbarContent(
                  title: 'Error',
                  message: 'Handling Categories',
                  contentType: ContentType.failure),
            ),
          );
        }
      },
      builder: (context, state) {
        var categories = AppCubit.get(context).categoryModel?.categories;
        if (state is GetAllCategoriesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetAllCategoriesFailure || categories == null) {
          return Center(
            child: Text('NO DATA'),
          );
        }
        allCategories = categories;
        final displayCategories =
            filteredCategories.isNotEmpty ? filteredCategories : allCategories;
        return Scaffold(
          appBar: AppBar(
            title: Text('Categories', style: AppTextStyle.appBarStyle()),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
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
                      hintText: 'Search Categories',
                      hintStyle: AppTextStyle.subTitle(),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                    itemCount: displayCategories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MealsByCategoryScreen(
                              categoryName:
                                  displayCategories[index].strCategory ??
                                      'Seafood',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 120.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: Constants.boxShadow),
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    displayCategories[index].strCategory ??
                                        'Cusisne',
                                    style: AppTextStyle.titleStyle(),
                                  ),
                                  Text(
                                    displayCategories[index]
                                            .strCategoryDescription ??
                                        'meat,goat',
                                    style: AppTextStyle.subTitle(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                            width: 100.w,
                            child: CachedNetworkImage(
                              imageUrl:
                                  displayCategories[index].strCategoryThumb ??
                                      '',
                              fit: BoxFit.contain,
                            ),
                          )
                        ]),
                      ),
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
