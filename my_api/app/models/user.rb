class User < ActiveRecord::Base
  validates :cpf, presence: true, uniqueness: { case_sensitive: false },
            numericality: { only_integer: true }

  has_many :accounts, dependent: :destroy
end
