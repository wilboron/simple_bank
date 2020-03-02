class UserController < ApplicationController
  def show
    @message = params[:id]
    render json: @message
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors
    end
  end

  private

  def user_params
    params.permit(:name, :email, :cpf)
  end
end
