require "rails_helper"

RSpec.describe "Watches", type: :request do

    before do 
      @user1 = User.create(email: 'test1@example.com', password: 'password123', password_confirmation: 'password123')
      @user2 = User.create(email: 'test2@example.com', password: 'password123', password_confirmation: 'password123')
      @watch = Watch.create(name: "First Watch", category: "standard", price:"122.00", user_id: @user1.id)

    end

    scenario "Sends a put request to update a watch signed user creator" do

        sign_in @user1

        patch "http://localhost:3000/watches/#{@watch.id}", params: {watch: {name: "Another Watch"}}
        expect(response).to have_http_status(:success)
        watch_updated = JSON.parse(response.body)
        expect(watch_updated["name"]).to eq("Another Watch")

    end

    scenario "Sends a put request to update a watch signed user random" do

        sign_in @user2

        patch "http://localhost:3000/watches/#{@watch.id}", params: {watch: {name: "Another Watch"}}
        expect(response).to have_http_status(403)


    end

    scenario "Sends a put request to update a watch unsigned user" do

        patch "http://localhost:3000/watches/#{@watch.id}", params: {watch: {name: "Another Watch"}}
        expect(response).to have_http_status(401)
       

    end
end