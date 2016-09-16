class CreateInstrumentsUsers < ActiveRecord::Migration
  def change
    create_table :instruments_users do |t|
      t.integer :instrument_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
