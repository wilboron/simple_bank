require 'rails_helper'

# Test account creation
RSpec.describe "Accounts", type: :request do
  describe "post /accounts" do
    let(:user) {
      User.new(name: 'Roberto Carlos Silva',
               cpf: '35356575809',
               email: 'roberto.carlos@gmail.com')
    }
    it 'create account' do
      user.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account', { user_id: 1,
                         number: '00000' }, headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:created)
    end
    it 'create wrong account' do
      user.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account', {user_id: 1}, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:bad_request)
    end
    it 'create account without user' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account', {user_id: 1}, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
  end
end

# Test account update
RSpec.describe "Accounts", type: :request do
  describe "post /accounts/update" do
    let(:acc) {
      Account.new(number: '00000', balance: 2000)
    }
    it 'update account' do
      acc.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/update', { number: '00000', balance: 1000 }, headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
    end
    it 'update non-existent account' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/update', { number: '00000' }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
  end
end

# Test account destroy
RSpec.describe "Accounts", type: :request do
  describe "post /accounts/destroy" do
    let(:acc) {
      Account.new(number: '00000', balance: 2000)
    }
    it 'destroy account' do
      acc.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/destroy', { number: '00000', balance: 1000 }, headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
    end
    it 'destroy non-existent account' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/destroy', { number: '00000' }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
  end
end

