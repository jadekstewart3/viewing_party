class AddPosterPathToParties < ActiveRecord::Migration[7.0]
  def change
    add_column :parties, :poster_path, :string
  end
end
