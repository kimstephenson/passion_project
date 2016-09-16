class CreateGenresUsers < ActiveRecord::Migration
  def change
    create_table :genres_users do |t|
      t.integer :genre_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
