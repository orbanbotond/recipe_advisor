class SearchController < ApplicationController
  include HomeIngredientsDisplayable

  before_action :load_home_ingredients

  def index
    @relevancy_params = { second_relevant: {cook_time: :asc}, most_relevant: { most_ingredients: :asc} }.deep_merge(most_relevant: { most_ingredients: params[:most_relevant_by_ingredient_nr] } )
    @relevancy_params = @relevancy_params.merge(second_relevant: second_relevant_sort_params) if params[:second_relevant].present?

    @relevant_receipts = RelevantRecipes.new.call(@relevancy_params)

    @relevant_receipts = @relevant_receipts.page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: @relevant_receipts }
     end
  end

  def second_relevant_sort_params
    params.permit(second_relevant: {}).to_h[:second_relevant]
  end
end