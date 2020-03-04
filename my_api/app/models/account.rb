class Account < ActiveRecord::Base
  belongs_to :user
  has_many :sent_transfers, class_name: 'Transfer', foreign_key: 'sender_id'
  has_many :received_transfers, class_name: 'Transfer', foreign_key: 'recipient_id'
  has_many :withdraws, dependent: :destroy

  validates :number, presence: true, uniqueness: true,
             numericality: { only_integer: true }

  def withdraw(amount)
    return false if (balance - amount).negative?

    self.balance -= amount
    return false unless withdraws.create(amount: withdraw_amount)

    save
  end

  def deposit(amount)
    self.balance += amount
    save
  end
end
