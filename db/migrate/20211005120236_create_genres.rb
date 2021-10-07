class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      
      t.integer :genre_id
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
