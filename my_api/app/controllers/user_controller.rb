class UserController < ApplicationController
  def view
    begin
      user = User.find(params[:user_id])
      render json: [user, accounts: user.accounts], status: :ok
    rescue ActiveRecord::RecordNotFound 
      render json: 'User not found', status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def update
    begin
      user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound 
      render json: 'User not found', status: :not_found; return
    end

    if user.update(user_params_edit)
      render json: user, status: :ok
    else
      render json: 'Error updating user', status: :bad_request
    end
  end

  def destroy
    begin
      user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound 
      render json: 'User not found', status: :not_found; return
    end

    if user.destroy
      render json: 'Destroyed', status: :ok
    else
      render json: 'Error destroying user', status: :bad_request
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
