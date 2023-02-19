class RelevantRecipes
	def call
		home_ingredients = HomeIngredient.pluck(:name).map{|x|"%#{x.downcase}%"}.join(",")
		are_all_ingredients_at_home = "SELECT LOWER(name) ~~ ANY('{#{home_ingredients}}') FROM ingredients WHERE ingredients.receipt_id = receipts.id"
		Receipt.where("true = all(#{are_all_ingredients_at_home})")
	end
end