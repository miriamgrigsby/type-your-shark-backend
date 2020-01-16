class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :points
      t.integer :sharks_killed
      t.string :difficulty

      t.timestamps
    end
  end
end
