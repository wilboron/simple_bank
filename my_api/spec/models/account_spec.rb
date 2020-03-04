require 'rails_helper'

describe Account do
  it 'is invalid does not contains number' do
    acc = Account.new(number: nil)
    expect(acc).to_not be_valid
  end

  it 'is invalid when number is alpha' do
    acc = Account.new(number: 'a')
    expect(acc).to_not be_valid
  end

  it 'is invalid when balance is alpha' do
    acc = Account.new(number: '00000', balance: 'a')
    expect(acc).to_not be_valid
  end

  it 'is invalid when balance is negative' do
    acc = Account.new(number: '00000', balance: -1)
    expect(acc).to_not be_valid
  end
end
