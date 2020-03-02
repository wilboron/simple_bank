class Account < ActiveRecord::Base
  belongs_to :user
  has_many :sent_transfers, class_name: 'Transfer', foreign_key: 'sender_id'
  has_many :received_transfers, class_name: 'Transfer', foreign_key: 'recipient_id'
  has_many :withdraws, dependent: :destroy

  validates :number, presence: true, uniqueness: { case_sensitive: false }

  def withdraw!(amount)
    return false if (self.balance - amount).negative?

    self.balance -= amount
  end

  def deposit!(amount)
    self.balance += amount
  end
end
