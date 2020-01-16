class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.string :total_games
      t.string :total_sharks_killed
      t.string :total_points
      t.timestamps
    end
  end
end
