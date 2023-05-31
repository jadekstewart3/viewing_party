class AddMovieTitleToParties < ActiveRecord::Migration[7.0]
  def change
    add_column :parties, :movie_title, :string
  end
end
