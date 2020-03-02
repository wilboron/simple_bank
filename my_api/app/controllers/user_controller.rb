class UserController < ApplicationController
  def view
    user = User.find(params[:user_id])
    render json: [user, accounts: user.accounts]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors
    end
  end

  def update
    user = User.find(params[:user_id])

    if user.update(user_params_edit)
      render json: user
    else
      render json: 'Error updating user'
    end
  end

  def destroy
    user = User.find(params[:user_id])
    if user.destroy
      render json: 'Destroyed'
    else
      render json: 'Error destroying user'
    end

  end
  private

  def user_params
    params.permit(:name, :email, :cpf)
  end

  def user_params_edit
    params.permit(:name, :email)
  end
end
