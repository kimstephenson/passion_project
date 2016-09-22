class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, unique: true
      t.string :password_hash, null: false
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :about_me

      t.timestamps null: false
    end
  end
end
