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

  def withdraw
    account = Account.find_by(number: params[:number])

    render json: 'Could not find account' if account.nil?

    withdraw_amount = params[:amount].to_f

    if account.withdraw(withdraw_amount)
      render json: account
    else
      render json: "You don't have the required balance for this withdrawl.
                    Balance: #{account.balance} Withdrawl: #{withdraw_amount}"
    end
  end

  def deposit
    account = Account.find_by(number: params[:number])

    if account.nil?
      render json: 'Could not find account'
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
    if account.destroy
      render json: 'Destroyed'
    else
      render json: 'Error destroying account'
    end
  end

  def transfer
    account_receiver = Account.find_by(number: params[:receiver_id])
    account_sender = Account.find_by(number: params[:sender_id])

    if account_sender.nil? || account_receiver.nil?
      render json: 'Could not find account'
      return
    end

    transfer = params[:transfer].to_f

    validade_transfer(account_sender, account_receiver, transfer)
    commit_transfer(account_sender, account_receiver, transfer)

    render json: [sender: [account_sender,
                  sent_transfers: account_sender.sent_transfers,
                  received_transfers: account_sender.received_transfers],
                  receiver: [account_receiver,
                  sent_transfers: account_receiver.sent_transfers,
                  received_transfers: account_receiver.received_transfers]]
  end

  def validade_transfer(account_sender, account_receiver, transfer)
    if (account_sender.balance - transfer).negative?
      render json: "Sender does not have the required amount.
      Sender balance: #{account_sender.balance} Transfer: #{transfer}"
    end

    if account_sender.user_id != account_receiver.user_id
      render json: 'Cannot transfer from a different user'
    end
  end

  def commit_transfer(account_sender, account_receiver, transfer)
    account_receiver.balance += transfer
    account_sender.balance -= transfer

    account_receiver.save
    account_sender.save

    @transfer = Transfer.new(amount: transfer,
                             sender_id: account_sender.id,
                             recipient_id: account_receiver.id)
    @transfer.save
  end
end
