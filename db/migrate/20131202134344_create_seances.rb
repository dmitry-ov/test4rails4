class CreateSeances < ActiveRecord::Migration
  def change
    create_table :seances do |t|
      t.string :begin
      t.string :datetime

      t.timestamps
    end
  end
end
