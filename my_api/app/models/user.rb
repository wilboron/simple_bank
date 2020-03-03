class User < ActiveRecord::Base
  validates :cpf, presence: true, uniqueness: true,
            numericality: { only_integer: true }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :accounts, dependent: :destroy
end
