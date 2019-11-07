class CreateInhas < ActiveRecord::Migration
  def change
    create_table :inhas do |t|
      
      t.integer :summoner_id #summoner db_id
      t.string :tier #티어
      t.string :division #티어단계
      t.integer :point #lp 포인트
      t.integer :win #승리 횟수
      t.integer :loose #패배 횟수
      t.integer :total_point #티어+단계+lp
      t.string :champion #숙련도 높은 챔피언
      
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
