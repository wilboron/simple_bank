class Transfer < ActiveRecord::Base
  belongs_to :sender, class_name: 'Account', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'Account', foreign_key: 'recipient_id'

  def validade_transfer
    if (@account_sender.balance - amount).negative?
      raise "Sender: #{@account_sender.user.name} does not have the required amount.
      Balance: #{@account_sender.balance} Transfer: #{amount}"
    end

    if @account_sender.user_id != @account_receiver.user_id
      raise 'Cannot transfer from a different user'
    end
  end

  def commit(sender_id, recipient_id)
    retrieve_accounts(sender_id, recipient_id)
    validade_transfer

    @account_receiver.balance += amount
    @account_sender.balance -= amount

    Account.transaction do
        @account_receiver.save!
        @account_sender.save!
        save!
    end

    [@account_receiver, @account_sender]
  end

  private

  def retrieve_accounts(sender_id, recipient_id)
    @account_receiver = Account.find_by(number: recipient_id)
    @account_sender = Account.find_by(number: sender_id)
    # Needs to update to account id not account number
    self.recipient_id = @account_receiver.id
    self.sender_id = @account_sender.id

    if @account_sender.nil? || @account_receiver.nil?
      raise 'Could not find account'
    end
  end
end
