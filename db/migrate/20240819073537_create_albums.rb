class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :year

      t.timestamps
    end
  end
end
