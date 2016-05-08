class CreateSummoners < ActiveRecord::Migration
  def change
    create_table :summoners do |t|
      
      t.string :summoner ##소환사이름
      t.string :summoner_number ##소환사 id
      t.string :university ##학교
      t.string :major ##전공
      t.string :admission ##학번
      t.boolean :sex ##성별
      
      t.timestamps null: false
    end
  end
end
