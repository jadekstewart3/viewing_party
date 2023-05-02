class CreateParties < ActiveRecord::Migration[7.0]
  def change
    create_table :parties do |t|
      t.string :date
      t.time :start_time
      t.integer :duration
      t.integer :movie_id

      t.timestamps
    end
  end
end
