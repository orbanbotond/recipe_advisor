class SearchController < ApplicationController
  include HomeIngredientsDisplayable

  before_action :load_home_ingredients

  def index
    @relevancy_params =  params[:relevant]
    @relevant_receipts = RelevantRecipes.new.call(params)

    @relevant_receipts = @relevant_receipts.page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: @relevant_receipts }
     end
  end
end