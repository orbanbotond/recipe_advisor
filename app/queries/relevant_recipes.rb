class RelevantRecipes
	def call
		home_ingredients = HomeIngredient.pluck(:name).map{|x|"%#{x.downcase}%"}.join(",")

		# The bellow subquery is going to return an array of booleans for each ingredient representing if the ingredient can be found at home
		are_ingredients_at_home = "SELECT LOWER(name) ~~ ANY('{#{home_ingredients}}') FROM ingredients WHERE ingredients.receipt_id = receipts.id"

		# Filtering for those reciped which have all ingredients at home.
		Receipt.where("true = all(#{are_ingredients_at_home})")
	end
end