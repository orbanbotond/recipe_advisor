class RelevantRecipes
	def call(params = {})
    relevancy_params = { most_relevant: { most_ingredients: :asc} }
    relevancy_params.deep_merge!(most_relevant: { most_ingredients: params.dig(:most_relevant, :most_ingredients) } ) if params.dig(:most_relevant, :most_ingredients).present?

		home_ingredients = HomeIngredient.select(:name).map{|record|"%#{record.name}%"}.join(",")

		are_ingredients_at_home = "SELECT name ~~* ANY('{#{home_ingredients}}') FROM ingredients AS ingrgnts WHERE ingrgnts.receipt_id = receipts.id"
		receipts = Receipt.joins("INNER JOIN ingredients AS ings ON ings.receipt_id = receipts.id").where("true = ALL(#{are_ingredients_at_home})" ).group("receipts.id").select("receipts.*, COUNT(ings.receipt_id) AS ingredient_number")

		receipts = receipts.order(ingredient_number: relevancy_params[:most_relevant][:most_ingredients])

		receipts.order(params[:second_relevant]) if params[:second_relevant].present?
	end
end