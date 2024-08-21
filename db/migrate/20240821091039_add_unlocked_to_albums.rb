class AddUnlockedToAlbums < ActiveRecord::Migration[7.1]
  def change
    add_column :albums, :unlocked, :boolean
  end
end
