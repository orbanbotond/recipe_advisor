module HomeIngredientsDisplayable
  extend ActiveSupport::Concern

  included do
  	def load_home_ingredients
  		@home_ingredients = HomeIngredient.all
  	end
  end

  class_methods do

  end
end