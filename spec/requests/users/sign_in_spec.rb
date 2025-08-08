require 'rails_helper'

RSpec.describe "User sign in", type: :request do
  let(:regular_user) { User.create(email: "user@test.com", password: "password", admin: false) }

  it "can sign in a regular user" do
    sign_in regular_user
    get root_path  # or another path where you'd expect the user to be authenticated

    # Check if the user is signed in by verifying the correct text
    expect(response.body).to include("Hello, user@test.com")  # Update this to match the correct text in your view
  end
end
