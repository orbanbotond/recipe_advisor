class HomeController < ApplicationController
  include HomeIngredientsDisplayable

  before_action :load_home_ingredients

  def index
  end
end