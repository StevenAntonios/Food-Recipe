class MealModel {
  List<Meals>? meals;

  MealModel({this.meals});

  MealModel.fromJson(Map<String, dynamic> json) {
    meals = json["meals"] == null
        ? null
        : (json["meals"] as List).map((e) => Meals.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (meals != null) {
      _data["meals"] = meals?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Meals {
  String? idMeal;
  String? strMeal;
  dynamic strDrinkAlternate;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  List<String> strIngredients;
  List<String> get validIngredients {
    return strIngredients.where((ingredient) =>   ingredient.isNotEmpty).toList();
  } // Changed to List<String>
  List<String> strMeasures;
  dynamic strSource;
  dynamic strImageSource;
  dynamic strCreativeCommonsConfirmed;
  dynamic dateModified;

  Meals(
      {this.idMeal,
      this.strMeal,
      this.strDrinkAlternate,
      this.strCategory,
      this.strArea,
      this.strInstructions,
      this.strMealThumb,
      this.strTags,
      this.strYoutube,
      List<String>? ingredients,
      List<String>? measures,

      this.strSource,
      this.strImageSource,
      this.strCreativeCommonsConfirmed,
      this.dateModified})
      : strIngredients = ingredients ?? List.filled(20, ''),
        strMeasures = measures ?? List.filled(20, '');

  Meals.fromJson(Map<String, dynamic> json)
      : idMeal = json["idMeal"],
        strMeal = json["strMeal"],
        strDrinkAlternate = json["strDrinkAlternate"],
        strCategory = json["strCategory"],
        strArea = json["strArea"],
        strInstructions = json["strInstructions"],
        strMealThumb = json["strMealThumb"],
        strTags = json["strTags"],
        strYoutube = json["strYoutube"],
        strIngredients = List.generate(20, (index) => json["strIngredient${index + 1}"] ?? ''), // Populate ingredients
        strMeasures = List.generate(20, (index) => json["strMeasure${index + 1}"] ?? ''), // Populate measures
        strSource = json["strSource"],
        strImageSource = json["strImageSource"],
        strCreativeCommonsConfirmed = json["strCreativeCommonsConfirmed"],
        dateModified = json["dateModified"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idMeal"] = idMeal;
    _data["strMeal"] = strMeal;
    _data["strDrinkAlternate"] = strDrinkAlternate;
    _data["strCategory"] = strCategory;
    _data["strArea"] = strArea;
    _data["strInstructions"] = strInstructions;
    _data["strMealThumb"] = strMealThumb;
    _data["strTags"] = strTags;
    _data["strYoutube"] = strYoutube;
    for (int i = 0; i < strIngredients.length; i++) {
      _data["strIngredient${i + 1}"] = strIngredients[i]; // Add ingredients back to JSON
      _data["strMeasure${i + 1}"] = strMeasures[i]; // Add measures back to JSON
    }
    _data["strSource"] = strSource;
    _data["strImageSource"] = strImageSource;
    _data["strCreativeCommonsConfirmed"] = strCreativeCommonsConfirmed;
    _data["dateModified"] = dateModified;
    return _data;
  }
}
