class HomeController < ApplicationController
  def index
    @home_ingredients = HomeIngredient.all
  end
end