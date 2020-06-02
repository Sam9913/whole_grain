class ProductDB{
	final double serving_size;
	final double totalWG_content_per_serving;
	final double totalWG_content;
	final double kcal_per_serving;
	final double total_fat;
	final double saturated_fat;
	final double monounsaturated_fat;
	final double polyunsaturated_fat;
	final double carbohydrate_double;
	final double fibre_double;
	final double total_sugar;
	final double protein_double;
	final double sodium_double;
	final double potassium_double;
	final double calcium_double;
	final double iron_double;
	final String image;
	final String productName;
	final String referenceKey;

  ProductDB({this.serving_size, this.totalWG_content_per_serving, this.totalWG_content, this.kcal_per_serving, this.total_fat,
			this.saturated_fat, this.monounsaturated_fat, this.polyunsaturated_fat, this.carbohydrate_double, this.fibre_double,
			this.total_sugar, this.protein_double, this.sodium_double, this.potassium_double, this.calcium_double, this.iron_double,
			this.image, this.productName, this.referenceKey});

	factory ProductDB.fromJson(Map<String, dynamic> json) {
		return ProductDB(
			serving_size: json["serving_size"].toDouble(),
			totalWG_content_per_serving: json["totalWG_content_per_serving"].toDouble(),
			totalWG_content: json["totalWG_content"].toDouble(),
			kcal_per_serving: json["kcal_per_serving"].toDouble(),
			total_fat: json["total_fat"].toDouble(),
			saturated_fat: json["saturated_fat"].toDouble(),
			monounsaturated_fat: json["monounsaturated_fat"].toDouble(),
			polyunsaturated_fat: json["polyunsaturated_fat"].toDouble(),
			carbohydrate_double: json["carbohydrate_double"].toDouble(),
			fibre_double:json[" fibre"].toDouble(),
			total_sugar: json["total_sugar"].toDouble(),
			protein_double: json["protein"].toDouble(),
			sodium_double: json["sodium"].toDouble(),
			potassium_double: json["potassium"].toDouble(),
			calcium_double: json["calcium"].toDouble(),
			iron_double: json["iron"].toDouble(),
			image: json["image"],
			productName: json["productName"],
			referenceKey: json["referenceKey"],
		);
	}

	Map<String, dynamic> toJson() => {
		"serving_size": serving_size,
		"totalWG_content_per_serving": totalWG_content_per_serving,
		"totalWG_content": totalWG_content,
		"kcal_per_serving": kcal_per_serving,
		"total_fat": total_fat,
		"saturated_fat": saturated_fat,
		"monounsaturated_fat": monounsaturated_fat,
		"polyunsaturated_fat": polyunsaturated_fat,
		"carbohydrate_double": carbohydrate_double,
		"fibre_double": fibre_double,
		"total_sugar": total_sugar,
		"protein_double": protein_double,
		"sodium_double": sodium_double,
		"potassium_double": potassium_double,
		"calcium_double": calcium_double,
		"iron_double": iron_double,
		"image": image,
		"productName": productName,
		"referenceKey": referenceKey,
	};
}