class CreateSeances < ActiveRecord::Migration
  def change
    create_table :seances do |t|
      
      t.belongs_to :film

      t.string :begin
      t.string :datetime

      t.timestamps
    end
  end
end
