class AccountController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @account = @user.accounts.create(number: params[:number])

    if @account.errors.any?
      render json: @account.errors
    else
      render json: @account
    end
  end
end
