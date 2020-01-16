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
             render json: {user_id: @user.id}
         else
             render json: {error: "Nice Try"}, status: :unauthorized 
         end
 
end
