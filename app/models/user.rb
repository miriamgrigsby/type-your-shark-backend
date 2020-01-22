class User < ApplicationRecord
    has_secure_password
    has_many :games, dependent: :destroy

    def all_games 
        Game.all.select{|game| game.user_id == self.id}
    end

    def total_sharks_killed 
        all_games.map{|game| game.sharks_killed}.sum
    end 

    def total_points
        all_games.map{|game| game.points}.sum
    end 

    def total_games 
        all_games.length
    end

    def avg_difficulty 
        gameDifficulty = 0.0
        all_games.each do |game| 
            if game.difficulty == "easy"
                gameDifficulty += 1.0
            elsif game.difficulty == "medium"
                gameDifficulty += 2.0
            else 
                gameDifficulty += 3.0
            end
        end
        if gameDifficulty == 0.0
            averageNumber = 1
        else 
            averageNumber = (gameDifficulty / all_games.length.to_f)
        end
        
        if averageNumber < 2.0
            "easy"
        elsif averageNumber < 2.5 && averageNumber >= 2.0
            "medium"
        elsif averageNumber >= 2.5
            "hard"
        end
    end
 
end
