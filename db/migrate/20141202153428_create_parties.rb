class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.integer :user_id
      t.string :name
      t.date :date
      t.integer :begin_hour
      t.string :artist
      t.integer :price
      t.string :adress
      t.text :description

      t.timestamps
    end
  end
end
