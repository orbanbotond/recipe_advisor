class HomeIngredientsController < ApplicationController
  def destroy
    @home_ingredient = HomeIngredient.find params[:id]
    @home_ingredient.destroy

    redirect_to root_path
  end

  def create
    @home_ingredient = HomeIngredient.create name: params[:home_ingredient][:name]

    redirect_to root_path
  end

  def new
    @home_ingredient = HomeIngredient.new
  end
end