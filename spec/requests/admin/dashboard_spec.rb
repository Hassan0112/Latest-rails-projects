require 'rails_helper'

RSpec.describe "User sign in", type: :request do
  let(:regular_user) { User.create(email: "user@test.com", password: "password", admin: false) }
  let(:admin_user) { User.create(email: "admin@test.com", password: "password", admin: true) }

  context "when regular user signs in" do
    it "can sign in a regular user" do
      sign_in regular_user
      get root_path  # or any other path where you'd expect the user to be authenticated

      # Check if the user is signed in by verifying the correct text
      expect(response.body).to include("Hello, user@test.com")
    end
  end

  context "when admin user signs in" do
    it "can sign in and access the admin dashboard" do
      sign_in admin_user
      get admin_dashboard_path  # Make sure to use the correct path for the admin dashboard

      # Check if the admin user can access the dashboard
      expect(response).to have_http_status(:ok)  # Expect HTTP 200 status (OK)
      expect(response.body).to include("Admin Dashboard")  # Check for a string in the admin dashboard
    end
  end
end
