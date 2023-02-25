class RelevantRecipes
	def call
		home_ingredients = HomeIngredient.select(:name).map{|record|"%#{record.name}%"}.join(",")

		are_ingredients_at_home = "SELECT name ~~* ANY('{#{home_ingredients}}') FROM ingredients AS ingrgnts WHERE ingrgnts.receipt_id = receipts.id"
		Receipt.joins("INNER JOIN ingredients AS ings ON ings.receipt_id = receipts.id").where("true = ALL(#{are_ingredients_at_home})" ).group("receipts.id").select("receipts.*, COUNT(ings.receipt_id) AS ingredient_number").order(ingredient_number: :asc)
	end
end