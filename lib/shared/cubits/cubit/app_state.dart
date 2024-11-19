part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class FilterMealsByEgyptLoading extends AppState{}
final class FilterMealsByEgyptSuccess extends AppState{}
final class FilterMealsByEgyptFailure extends AppState{}


final class FilterMealsByAmericaLoading extends AppState{}
final class FilterMealsByAmericaSucces extends AppState{}
final class FilterMealsByAmericaFailure extends AppState{}


final class GetSingleMealDetailesLoading extends AppState{}
final class GetSingleMealDetailesSuccess extends AppState{}
final class GetSingleMealDetailesFailure extends AppState{}


final class GetAllCategoriesLoading extends AppState{}
final class GetAllCategoriesSuccess extends AppState{}
final class GetAllCategoriesFailure extends AppState{}


final class GetMealsByCategoryLoading extends AppState{}
final class GetMealsByCategorySuccess extends AppState{}
final class GetMealsByCategoryFailure extends AppState{}

final class GetRandomMealLoading extends AppState{}
final class GetRandomMealSucces extends AppState{}
final class GetRandomMealFailure extends AppState{}
