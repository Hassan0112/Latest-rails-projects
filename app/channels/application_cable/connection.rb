module ApplicationCable
  class Connection < ActionCable::Connection::Base
  
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    def disconnect
      # Any cleanup when user disconnects
    end


    private

    def verified_user
      if user = User.find_by( id: cookies.signed[:user_id])
        user
      else
        reject_unauthorized_connection
      end 
    end

  end
end
