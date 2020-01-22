class GamesController < ApplicationController
 
    before_action :find_game, only: [:show, :update, :destroy]

    def index
        @games = Game.all
        render json: @games
    end
    
    def show 
        render json: @game
    end

    def create
        @game = Game.new(game_params)
        if @game.valid?
            @game.save
            render json: @game
        else 
        end
    end

    def update
        if @game.update(game_params)
            render json: @game
        else
            render json: @game.errors, status: :unprocessable_entity
        end
    end

    def destroy 
        @game.destroy
    end

    private 
    
    def find_game
        @game = Game.find(params[:id])
    end 

    def game_params
        params.permit(
            :points,
            :sharks_killed,
            :difficulty, 
            :user_id
        )
    end
end

