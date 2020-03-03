require 'rails_helper'

describe User do
  it 'is valid when contains cpf, name and email' do
    user = User.new(name: 'Roberto Carlos Silva',
                    cpf: '35356575809',
                    email: 'roberto.carlos@gmail.com')
    expect(user).to be_valid
  end

  it 'is not valid when the name is null' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is not valid when the email is null' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is not valid when the cpf is null' do
    user = User.new(cpf: nil)
    user.valid?
    expect(user.errors[:cpf]).to include("can't be blank")
  end
end

describe User do
  it 'cannot have the same email' do
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com').save

    user = User.new(name: 'Roberto Carlos Silva',
                    cpf: '35356575809',
                    email: 'roberto.carlos@gmail.com')

    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'cannot have the same CPF' do
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com').save

    user = User.new(name: 'Roberto Carlos Silva',
                    cpf: '35356575809',
                    email: 'roberto.carlos@gmail.com')

    user.valid?
    expect(user.errors[:cpf]).to include('has already been taken')
  end
end
