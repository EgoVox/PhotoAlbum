class CreateShareableLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :shareable_links do |t|
      t.string :token
      t.references :album, null: false, foreign_key: true
      t.datetime :expires_at

      t.timestamps
    end
  end
end
