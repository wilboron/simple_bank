class UserController < ApplicationController
  def show
    @message = params[:id]
    render json: @message
  end
end
