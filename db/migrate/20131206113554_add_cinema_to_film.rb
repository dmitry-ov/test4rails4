class AddCinemaToFilm < ActiveRecord::Migration
  def change
    add_column :films, :cinema, :string
  end
end
