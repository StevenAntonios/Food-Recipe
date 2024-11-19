import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/models/area_mode.dart';
import 'package:meal_app/models/category_model.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:meal_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:meal_app/shared/network/remote/endpoints/end_points.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  MealModel? mealCategoryModel;
  CategoryModel? categoryModel;
  AreaModel? egyptModel;
  AreaModel? americaModel;
  MealModel? singleMealModel;
  MealModel? randomMealModel;

  void getMealsInEgypt() async {
    emit(FilterMealsByEgyptLoading());
    try {
      Response response =
          await DioHelper.getRequest(endPoint: EndPoints.filterByEgypt);
      egyptModel = AreaModel.fromJson(response.data);
      if (response.statusCode! == 200 && response.data['meals'] != null) {
        emit(FilterMealsByEgyptSuccess());
      } else {
        emit(FilterMealsByEgyptFailure());
      }
    } catch (e) {
      emit(FilterMealsByEgyptFailure());
    }
  }

  void getMealsInAmerica() async {
    emit(FilterMealsByAmericaLoading());
    try {
      Response response =
          await DioHelper.getRequest(endPoint: EndPoints.filterByAmerican);
      americaModel = AreaModel.fromJson(response.data);

      if (response.statusCode! == 200 && response.data['meals'] != null) {
        emit(FilterMealsByAmericaSucces());
      } else {
        log(response.data);
        emit(FilterMealsByAmericaFailure());
      }
    } catch (e) {
      emit(FilterMealsByAmericaFailure());
    }
  }

  void getMealDetails(String id) async {
    emit(GetSingleMealDetailesLoading());
    try {
      Response response =
          await DioHelper.getRequest(endPoint: '${EndPoints.getSingleMeal}$id');
      singleMealModel = MealModel.fromJson(response.data);

      if (response.statusCode! == 200 && response.data['meals'] != null) {
        log('succes');
        emit(GetSingleMealDetailesSuccess());
      } else {
        emit(GetSingleMealDetailesFailure());
        log('str==null');
      }
    } catch (e) {
      emit(GetSingleMealDetailesFailure());
      log('Faileddd');
    }
  }

  void getAllCategories() async {
    emit(GetAllCategoriesLoading());

    try {
      Response response =
          await DioHelper.getRequest(endPoint: EndPoints.allCategories);
      categoryModel = CategoryModel.fromJson(response.data);
      if (response.statusCode == 200) {
        emit(GetAllCategoriesSuccess());
      } else {
        emit(GetAllCategoriesFailure());
      }
    } catch (e) {
      emit(GetAllCategoriesFailure());
    }
  }

  void getMealByCategory(String strCategory) async {
    emit(GetMealsByCategoryLoading());
    try {
      Response response = await DioHelper.getRequest(
          endPoint: '${EndPoints.FilterByCategory}$strCategory');
      mealCategoryModel = MealModel.fromJson(response.data);
      if (response.statusCode == 200) {
        emit(GetMealsByCategorySuccess());
      } else {
        emit(GetMealsByCategoryFailure());
      }
    } catch (e) {
      emit(GetMealsByCategoryFailure());
    }
  }

  void getRandomMealModel() async {
    emit(GetRandomMealLoading());
    try {
      Response response =
          await DioHelper.getRequest(endPoint: EndPoints.randomMeal);
      randomMealModel = MealModel.fromJson(response.data);

      if (response.statusCode == 200) {
        emit(GetRandomMealSucces());
        log('Success');
      } else {
        emit(GetRandomMealFailure());
        log('Failed');
      }
    } catch (e) {
      emit(GetRandomMealFailure());
      log('Faileeeeeeeeeeeeeeeeeeeeeeed');
    }
  }
}
