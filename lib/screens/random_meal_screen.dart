
import 'dart:developer';

import 'package:meal_app/index.dart';

class RandomMealScreen extends StatefulWidget {
  const RandomMealScreen({super.key});

  @override
  State<RandomMealScreen> createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  void initState() {
    super.initState();
    context.read<AppCubit>().getRandomMealModel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetRandomMealFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: AwesomeSnackbarContent(
                  title: 'Error',
                  message: 'Handling Random contente',
                  contentType: ContentType.failure),
            ),
          );
        }
      },
      builder: (context, state) {
        var meal = AppCubit.get(context).randomMealModel?.meals?.first;
        if (state is GetRandomMealLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetRandomMealFailure || meal == null) {
          return const  Center(
            child: Text('No Meals'),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              meal.strCategory ?? 'Koshari',
              style: AppTextStyle.appBarStyle(),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 230.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: meal.strMealThumb ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text(
                          'Category',
                          style: AppTextStyle.titleStyle(),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          meal.strCategory ?? 'Category',
                          style: AppTextStyle.bodyStyle(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text(
                          'Country',
                          style: AppTextStyle.titleStyle(),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          meal.strArea ?? 'Egypt',
                          style: AppTextStyle.bodyStyle(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Instructions',
                      style: AppTextStyle.titleStyle(),
                    ),
                    Text(
                      meal.strInstructions ??
                          'Koshari is a beloved Egyptian comfort food made with rice, lentils, and pasta topped with spicy tomato sauce and crispy onions.',
                      style: AppTextStyle.bodyStyle(),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Tutorial',
                      style: AppTextStyle.titleStyle(),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          String url = 'https://flutter.dev';
                          final Uri _url = Uri.parse(meal.strYoutube ?? url);
                          Future<void> _launchUrl() async {
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          }

                          _launchUrl();
                          log('tabbed');
                        },
                        child: SvgPicture.asset(
                          'assets/svgs/youtube-color-svgrepo-com.svg',
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Ingredients',
                      style: AppTextStyle.titleStyle(),
                    ),
                    SizedBox(height: 10.h),
                    ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: meal.validIngredients.length,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 4.h,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              // border: Border.all(color: Colors.grey.shade200),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200, blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  meal.validIngredients[index]  ,
                                  style: AppTextStyle.bodyStyle(),
                                ),
                                Text(
                                  meal.strMeasures[meal.strIngredients.indexOf(
                                          meal.validIngredients[index])] 
                                      ,
                                  style: AppTextStyle.bodyStyle(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
