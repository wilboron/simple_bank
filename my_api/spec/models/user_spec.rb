require 'rails_helper'

describe User do
  subject {
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com')
  }

  it 'is valid when contains cpf, name and email' do
    expect(subject).to be_valid
  end

  it 'is not valid when the name is null' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid when the email is null' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid when the cpf is null' do
    subject.cpf = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid when the cpf is string' do
    subject.cpf = 'value'
    expect(subject).to_not be_valid
  end
end

describe User do
  let(:user1) {
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com')
  }
  let(:user2) {
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com')
    }

  it 'cannot have the same email' do
    user1.save
    user2.valid?
    expect(user2.errors[:email]).to include('has already been taken')
  end

  it 'cannot have the same CPF' do
    user1.save
    user2.valid?
    expect(user2.errors[:cpf]).to include('has already been taken')
  end
end
