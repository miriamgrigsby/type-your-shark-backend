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
     before_action :find_user, only: [:update, :destroy, :show]

     def index
         @user = User.all
         render json: @user, include: :games
     end
 
     def show
        render json: @user, include: :games
     end

     def profile
        authorization_header = request.headers[:authorization]
        if !authorization_header
         render status: :unauthorized
        else
         token = authorization_header.split(" ")[1]
         secret_key = Rails.application.secrets.secret_key_base[0]
         decoded_token = JWT.decode(token, secret_key)
         user = User.find(decoded_token[0]["user_id"])
         render json: user 
        end
     end

     def create
        @user = User.create(user_params)
        secret_key = process.env.SECRET_KEY_BASE
        token = JWT.encode({user_id: @user.id}, secret_key)
        render json: {token: token, user: {
            user_id: @user.id,  
            total_games: @user.total_games, 
            total_sharks_killed: @user.total_sharks_killed,
            total_points: @user.total_points,
            password_digest: nil, 
            avg_difficulty: @user.avg_difficulty
        }}
     end
 
     def update
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

    def destroy
        @user.destroy
    end

    private

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit([:username, :password, :total_games, :total_sharks_killed, :total_points, :avg_difficulty])
    end
 
end

