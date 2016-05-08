class CreateJnus < ActiveRecord::Migration
  def change
    create_table :jnus do |t|
      
      t.integer :summoner_id #summoner db_id
      t.string :tier #티어
      t.string :division #티어단계
      t.integer :point #lp 포인트
      t.integer :win #승리 횟수
      t.integer :loose #패배 횟수
      t.integer :total_point #티어+단계+lp
      t.string :champion #숙련도 높은 챔피언
      
      t.timestamps null: false
    end
  end
end
