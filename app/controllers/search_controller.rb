class SearchController < ApplicationController
  include HomeIngredientsDisplayable

  before_action :load_home_ingredients

  def index
    @relevant_receipts = RelevantRecipes.new.call
  end
end