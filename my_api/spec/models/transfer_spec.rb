require 'rails_helper'

describe Transfer do
  let(:user) {
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com')
  }
  let(:acc1) {
    Account.new(number: '00000',
                balance: 10_000,
                user_id: user.id)
  }

  let(:acc2) {
    Account.new(number: '00001',
                balance: 10_000,
                user_id: user.id)
  }

  it 'is valid when sender and receiver has correct value' do
    user.save
    acc1.save
    acc2.save
    transfer = Transfer.new(amount: 1000.0)

    acc_result1, acc_result2 = transfer.commit(acc1.number, acc2.number)

    expect(acc_result2.balance).to eq(9000)
    expect(acc_result1.balance).to eq(11_000)
  end

  it 'is invalid when sender dont have balance' do
    user.save
    acc1.balance = 1
    acc1.save
    acc2.save
    transfer = Transfer.new(amount: 1000.0)

    expect {transfer.commit(acc1.number, acc2.number)}.to raise_error(RuntimeError)
  end


  it 'is invalid when amount is negative' do
    user.save
    acc1.save
    acc2.save
    transfer = Transfer.new(amount: -1000.0)

    expect(transfer).to_not be_valid
  end

  it 'is invalid when amount is zero' do
    user.save
    acc1.save
    acc2.save
    transfer = Transfer.new(amount: 0)

    expect(transfer).to_not be_valid
  end

  it 'is invalid when amount is string' do
    user.save
    acc1.save
    acc2.save
    transfer = Transfer.new(amount: 'value')

    expect(transfer).to_not be_valid
  end
end
