require 'rails_helper'

describe Withdraw do
  let(:user) {
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com')
  }
  let(:acc) {
    Account.new(number: '00000',
                balance: 10_000,
                user_id: user.id)
  }

  it 'is invalid when amount is negative' do
    user.save; acc.save
    acc.withdraws.create(amount: -1)

    expect(acc.withdraws.first).to_not be_valid
  end

  it 'is invalid when amount is zero' do
    user.save; acc.save
    acc.withdraws.create(amount: 0)

    expect(acc.withdraws.first).to_not be_valid
  end

  it 'is invalid when amount is string' do
    user.save; acc.save
    acc.withdraws.create(amount: 'value')

    expect(acc.withdraws.first).to_not be_valid
  end

  it 'is invalid when amount is higher then balance' do
    user.save; acc.save
    expect(acc.withdraw(5000000)).to be(false)
  end

  it 'is valid when amount is lower then balance' do
    user.save; acc.save
    expect(acc.withdraw(100)).to be(true)
  end

  it 'is valid when account balance reflects the withdraw' do
    user.save; acc.save
    acc.withdraw(1000)
    expect(acc.balance).to eq(9000)
  end

end
