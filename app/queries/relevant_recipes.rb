class RelevantRecipes
	def call
		home_ingredients = HomeIngredient.select(:name).map{|record|"%#{record.name}%"}.join(",")

		are_ingredients_at_home = "SELECT name ~~* ANY('{#{home_ingredients}}') FROM ingredients WHERE ingredients.receipt_id = receipts.id"
		Receipt.where("true = ALL(#{are_ingredients_at_home})" )
	end
end