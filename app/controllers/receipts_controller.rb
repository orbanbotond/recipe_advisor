class ReceiptsController < ApplicationController
  def show
    @receipt = Receipt.find params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @receipt }
     end
  end
end