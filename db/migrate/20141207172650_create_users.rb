class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :password_verif
      t.string :email

      t.timestamps
    end
  end
end