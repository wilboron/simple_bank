class AccountController < ApplicationController
  def create
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: 'User not found', status: :not_found
      return
    end

    @account = @user.accounts.create(number: params[:number])

    if @account.errors.any?
      render json: @account.errors, status: :bad_request
    else
      render json: @account, status: :created
    end
  end

  def update  
    account = Account.find_by(number: params[:number])

    if account.nil?
      render json: 'Account not found', status: :not_found
      return
    end
   

    if account.update(account_params_edit)
      render json: account, status: :ok
    else
      render json: 'Error updating user', status: :bad_request
    end
  end

  def withdraw
    account = Account.find_by(number: params[:number])

    if account.nil?
      render json: 'Account not found', status: :not_found
      return
    end

    withdraw_amount = params[:amount].to_f

    if account.withdraw(withdraw_amount)
      render json: account
    else
      render json: "You don't have the required balance for this withdrawl.
                    Balance: #{account.balance} Withdrawl: #{withdraw_amount}", status: :bad_request
    end
  end

  def deposit
    account = Account.find_by(number: params[:number])

    if account.nil?
      render json: 'Could not find account', status: :not_found
      return
    end

    deposit_amount = params[:amount].to_f
    account.deposit(deposit_amount)
    render json: account
  end

  def view
    account = Account.find_by(number: params[:number])
    render json: [account, withdrawl: account.withdraws,
                           sent_transfers: account.sent_transfers,
                           received_transfers: account.received_transfers]
  end

  def destroy
    account = Account.find_by(number: params[:number])

    if account.nil?
      render json: 'Account not found', status: :not_found
      return
    end

    if account.destroy
      render json: 'Destroyed'
    else
      render json: 'Error destroying account', status: :bad_request
    end
  end

  def transfer
    transfer = Transfer.new(amount: params[:transfer].to_f)
    begin
      acc_receiver, acc_sender = transfer.commit(
                                      params[:sender_id],
                                      params[:receiver_id])
    rescue => e
      render json: e.message, status: :bad_request
      return
    end
    render json: make_array_transfer(acc_receiver, acc_sender)
  end

  private

  def make_array_transfer(account_receiver, account_sender)
    [sender:
    [account_sender,
     sent_transfers: account_sender.sent_transfers,
     received_transfers: account_sender.received_transfers],
     receiver: [account_receiver,
                sent_transfers: account_receiver.sent_transfers,
                received_transfers: account_receiver.received_transfers]]
  end

  def account_params_edit
    params.permit(:balance)
  end

end
