class SearchController < ApplicationController
  include HomeIngredientsDisplayable

  before_action :load_home_ingredients

  def index
    @relevant_receipts = RelevantRecipes.new.call

    @relevant_receipts = @relevant_receipts.page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: @relevant_receipts }
     end
  end
end