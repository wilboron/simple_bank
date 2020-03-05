require 'rails_helper'

# Test user creation
RSpec.describe 'Users', type: :request do
  describe 'POST /user' do
    it 'create user' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/user', { name: 'Roberto Carlos',
                      email: 'roberto.carlos@gmail.com',
                      cpf: '35356575804' }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:created)
    end
    it 'create wrong user' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/user', {}, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:bad_request)
    end
  end
end

# Test view user
RSpec.describe 'Users', type: :request do
  subject {
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com')
  }
  describe 'POST /user/view' do
    it 'view user' do
      subject.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/user/view', { user_id: 1 }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
    end
    it 'try to view non-existent user' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/user/view', { user_id: 1 }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
  end
end

# Test update user
RSpec.describe 'Users', type: :request do
  subject {
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com')
  }
  describe 'POST /user/update' do
    it 'update user' do
      subject.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/user/update', {user_id: 1, name: 'Guilherme Miojo' }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
    end
    it 'try to update non-existent user' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/user/update', { user_id: 1 }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
  end
end

# Test destroy user
RSpec.describe 'Users', type: :request do
  subject {
    User.new(name: 'Roberto Carlos Silva',
             cpf: '35356575809',
             email: 'roberto.carlos@gmail.com')
  }
  describe 'POST /user/destroy' do
    it 'destroy user' do
      subject.save
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/user/update', {user_id: 1 }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
    end
    it 'try to destroy non-existent user' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      post '/user/destroy', { user_id: 1 }, headers
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
  end
end
