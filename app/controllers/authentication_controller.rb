class AuthenticationController < ApplicationController
    def login
        username = params[:username]
        password = params[:password]

        @user = User.find_by(username: username)
        
        if !@user
            render json: {error: "Invalid Credentials"}, status: :unauthorized
        else 
            if !@user.authenticate(password)
                render json: {error: "Invalid Credentials"}, status: :unauthorized
            else 
                # secret_key = ENV["SECRET_KEY_BASE"]
                secret_key = Rails.application.secrets.secret_key_base

                token = JWT.encode({user_id: @user.id}, secret_key)
                render json: {token: token, user: @user}, include: :games
                
            end
        end
    end
end
