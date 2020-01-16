class JsonWebToken
    
    SECRET = Rails.application.secrets.secret_key_base.to_s
    def self.encode(payload)
        payload[:exp] = 24.hours.from_now.to_i
        JWT.encode(payload, SECRET)
    end

    def self.decode(token)
        JWT.decode(token, SECRET)[0]
    end

end
class UsersController < ApplicationController
     # before_action :verify_user, except: [:create, :index]
     before_action :find_user, only: [:update]

     def index
         @user = User.all
         render json: @user
     end
 
     def create
         @user = User.create(user_params)
         render json: @user, status: :created
     end
 
     def update
         # byebug
         header = request.headers["Authorization"]
         token = header.split(" ").last
       
       
         payload = JsonWebToken.decode(token)
 
         if (@user.id == payload["user_id"].to_i)
             @user.update(user_params)
             render json: {user: @user}
         else
             render json: {error: "Nice Try"}, status: :unauthorized 
         end
    end


    private
    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit([:username, :password, :total_games, :total_sharks_killed, :total_points])
    end
 
end

