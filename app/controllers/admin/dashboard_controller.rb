class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action  :check_admin!

  def index
    @total_users = User.count
  end


  def check_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied"
    end
  end

end
