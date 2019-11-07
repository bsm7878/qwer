class CreateUnivMajors < ActiveRecord::Migration
  def change
    create_table :univ_majors do |t|
      
      t.string :univ_name
      
      t.timestamps null: false
    end
  end
end
