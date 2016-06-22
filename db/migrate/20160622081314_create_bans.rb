class CreateBans < ActiveRecord::Migration
  def change
    create_table :bans do |t|
      
      t.string :ban_summoner
      
      t.timestamps null: false
    end
  end
end
