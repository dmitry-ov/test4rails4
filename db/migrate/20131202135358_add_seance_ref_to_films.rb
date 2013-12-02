class AddSeanceRefToFilms < ActiveRecord::Migration
  def change
    add_reference :films, :seance, index: true
  end
end
