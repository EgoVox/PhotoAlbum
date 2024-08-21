class AddPrivateAndPasswordToAlbums < ActiveRecord::Migration[7.1]
  def change
    add_column :albums, :private, :boolean, default: false
    add_column :albums, :password, :string
  end
end
