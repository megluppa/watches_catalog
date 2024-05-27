require "rails_helper"

RSpec.describe "Watches", type: :request do

  before do
    
      user = User.create(email: 'test1@example.com', password: 'password123', password_confirmation: 'password123')
      Watch.create(name: "First Watch", category: "standard", price:"122.00", user_id: user.id)
      Watch.create(name: "Second Watch", category: "premium", price:"50000.00", user_id: user.id)
      Watch.create(name: "Third Watch", category: "premium+", price:"3000.00", user_id: user.id)

  end

  scenario "Get all watches and checks the array length" do
      get "http://localhost:3000/watches"
      expect(response).to have_http_status(:success)
      posts = JSON.parse(response.body)
      expect(posts.length).to eq(3)

  end
end
