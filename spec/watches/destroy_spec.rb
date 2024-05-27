require "rails_helper"

RSpec.describe "Watches", type: :request do

    before do
      @user = User.create(email: 'test1@example.com', password: 'password123', password_confirmation: 'password123')
      @watch1 = Watch.create(name: "First Watch", category: "standard", price:"122.00", user_id: @user.id)
    end

    scenario "Sends a delete request to delete a watch signed in user" do
        sign_in @user
                
        delete "http://localhost:3000/watches/#{@watch1.id}"
        expect(response).to have_http_status(:success)

        get "http://localhost:3000/watches"

        expect(response).to have_http_status(:success)
        watches = JSON.parse(response.body)
        expect(watches.length).to eq(0)

    end

    scenario "Sends a delete request to delete a watch unsigned user" do               
        delete "http://localhost:3000/watches/#{@watch1.id}"
        expect(response).to have_http_status(401)

        get "http://localhost:3000/watches"

        expect(response).to have_http_status(:success)
        watches = JSON.parse(response.body)
        expect(watches.length).to eq(1)

    end

end