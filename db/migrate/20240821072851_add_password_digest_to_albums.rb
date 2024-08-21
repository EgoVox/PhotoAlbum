class AddPasswordDigestToAlbums < ActiveRecord::Migration[7.1]
  def change
    add_column :albums, :password_digest, :string
  end
end
