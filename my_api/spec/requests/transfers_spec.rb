require 'rails_helper'

RSpec.describe "Transfers", type: :request do
  describe "post /account/transfer" do
    let(:user) {
      User.new(name: 'Roberto Carlos Silva',
               cpf: '35356575809',
               email: 'roberto.carlos@gmail.com')
    }
    let(:user2) {
      User.new(name: 'Roberto Carlos Silva',
               cpf: '353565758091',
               email: 'roberto.carlos1@gmail.com')
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

    it 'test a valid transfer' do
      user.save
      acc1.save
      acc2.save

      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/transfer', { receiver_id: '00000', sender_id: '00001', transfer: 1000 }, headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)

    end
    it 'test a invalid account in transfer' do
      user.save
      acc1.save

      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/transfer', { receiver_id: '00000', sender_id: '00600', transfer: 1000 }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:bad_request)
    end
    it 'test transfer between different users' do
      user.save
      user2.save
      acc1.save
      acc2.user_id = user2.id
      acc2.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/account/transfer', { receiver_id: '00000', sender_id: '00001', transfer: 1000 }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:bad_request)
    end
  end
end
