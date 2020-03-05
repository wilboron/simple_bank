require 'rails_helper'

RSpec.describe "Withdraws", type: :request do
  describe "post /accounts/destroy" do
    let(:acc) {
      Account.new(number: '00000', balance: 2000)
    }
    it 'withdraw valid amount from account' do
      acc.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/withdraw', { number: '00000', amount: 1000 }, headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
    end
    it 'withdraw from non-existent account' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/withdraw', { number: '00000' }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
    it 'withdraw invalid amount account' do
      acc.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/withdraw', { number: '00000', amount: 3000 }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:bad_request)
    end
  end
end
