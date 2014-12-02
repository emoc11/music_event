class CreatePartyUsers < ActiveRecord::Migration
  def change
    create_table :party_users do |t|
      t.integer :user_id
      t.integer :party_id

      t.timestamps
    end
  end
end
