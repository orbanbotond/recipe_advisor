class RelevantRecipes
	def call(params = {})
		home_ingredients = HomeIngredient.select(:name).map{|record|"%#{record.name}%"}.join(",")

		are_ingredients_at_home = "SELECT name ~~* ANY('{#{home_ingredients}}') FROM ingredients AS ingrgnts WHERE ingrgnts.receipt_id = receipts.id"
		receipts = Receipt.joins("INNER JOIN ingredients AS ings ON ings.receipt_id = receipts.id").where("true = ALL(#{are_ingredients_at_home})" ).group("receipts.id").select("receipts.*, COUNT(ings.receipt_id) AS ingredient_number")
		if params[:relevant] == :most_ingredients
			receipts.order(ingredient_number: :desc)
		else
			receipts.order(ingredient_number: :asc)
		end
	end
end