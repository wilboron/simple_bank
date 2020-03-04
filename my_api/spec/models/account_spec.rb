require 'rails_helper'

describe Account do
  it 'is invalid does not contains number' do
    acc = Account.new(number: nil)
    expect(acc).to_not be_valid
  end

  it 'is invalid when contains number and is alpha' do
    acc = Account.new(number: 'a')
    expect(acc).to_not be_valid
  end
end
