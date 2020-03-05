class Account < ActiveRecord::Base
  belongs_to :user
  has_many :sent_transfers, class_name: 'Transfer', foreign_key: 'sender_id'
  has_many :received_transfers, class_name: 'Transfer', foreign_key: 'recipient_id'
  has_many :withdraws, dependent: :destroy

  validates :number, presence: true, uniqueness: true,
             numericality: { only_integer: true }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def withdraw(amount)
    return false if (balance - amount).negative?

    self.balance -= amount

    return false unless withdraws.create(amount: amount)

    save
  end

  def deposit(amount)
    self.balance += amount
    save
  end
end
