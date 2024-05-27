require "rails_helper"

RSpec.describe "Watches", type: :request do

  before do
    user = User.create(email: 'test1@example.com', password: 'password123', password_confirmation: 'password123')
    @watch = Watch.create(name: "First Watch", category: "standard", price:"122.00", user_id: user.id)
    Watch.create(name: "Second Watch", category: "premium", price:"50000.00", user_id: user.id)
    Watch.create(name: "Third Watch", category: "premium+", price:"3000.00", user_id: user.id)

  end

    scenario "gets the first watch" do 

        get "http://localhost:3000/watches/#{@watch.id}"

        expect(response).to have_http_status(:success)
        post = JSON.parse(response.body)
        expect(post["name"]).to eq("First Watch")
        expect(post["category"]).to eq("standard")
        expect(post["price"]).to eq("122.0")


    end

    # scenario "gets the second post" do 

    #     get "http://localhost:3000/posts/2"

    #     expect(response).to have_http_status(:success)
    #     post = JSON.parse(response.body)
    #     expect(post["title"]).to eq("Second Post")
    #     expect(post["body"]).to eq("This is the second post")

    # end
end