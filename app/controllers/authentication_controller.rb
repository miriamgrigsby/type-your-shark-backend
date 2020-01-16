class AuthenticationController < ApplicationController
    def login
        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by(username: username)

        if !@user
            render status: :unauthorized
        else 
            if !@user.authenticate(password)
                secret_key = Rails.application.secrets.secret_key_base[0]
                token = JWT.encode(@user, secret_key)
                render json: {token: token}
            else 
                render status: :unauthorized
            end
        end
    end
end
