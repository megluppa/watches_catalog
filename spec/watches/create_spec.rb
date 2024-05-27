require "rails_helper"

RSpec.describe "Posts", type: :request do

    before do
      @user = User.create(email: 'test1@example.com', password: 'password123', password_confirmation: 'password123')
    end

    scenario "Sends a post request to create a watch signed user" do
        sign_in @user
        post "http://localhost:3000/watches", params: {watch: {name: "First watch", category: "standard", price:11000}}

        expect(response).to have_http_status(:success)
        watch = JSON.parse(response.body)
        expect(watch["name"]).to eq("First watch")
        expect(watch["category"]).to eq("standard")
        expect(watch["price"]).to eq("11000.0")

    end

    scenario "Sends a post request to create a watch unsigned user" do
        post "http://localhost:3000/watches", params: {watch: {name: "First watch", category: "standard", price:11000}}

        expect(response).to have_http_status(401)

    end
end